import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Every table is now editable and removable from its own row, so these prove
/// the two halves of that: an update changes only what was passed, and a delete
/// takes the record out of every read without losing the row.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late Fixtures fx;
  late String branchId;
  late String memberId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    fx = Fixtures(db);
    branchId = await fx.branch();
    memberId = await fx.member(branchId: branchId);
  });

  tearDown(() => db.close());

  test('editing a gift changes the amount and leaves the rest alone', () async {
    final id = await repo.recordDonation(
      branchId: branchId,
      memberId: memberId,
      donorName: 'Grace Test',
      amount: 100,
      fund: GivingFund.tithe,
      method: PaymentMethod.cash,
      date: DateTime.utc(2026, 5, 1),
      reference: 'TXN-KEEP',
    );

    await repo.updateDonation(id, amount: 250, fund: GivingFund.building);

    final saved =
        (await repo.watchDonations().first).firstWhere((d) => d.id == id);
    expect(saved.amount, 250);
    expect(saved.fund, GivingFund.building);
    // Untouched columns must survive an update that did not mention them.
    expect(saved.method, PaymentMethod.cash);
    expect(saved.reference, 'TXN-KEEP');
    expect(saved.donorName, 'Grace Test');
  });

  test('a deleted gift disappears from the ledger', () async {
    final id = await repo.recordDonation(
      branchId: branchId,
      donorName: 'Anonymous',
      amount: 40,
      fund: GivingFund.offering,
      method: PaymentMethod.cash,
      date: DateTime.utc(2026, 5, 2),
    );

    expect((await repo.watchDonations().first).map((d) => d.id), contains(id));
    await repo.deleteDonation(id);
    expect(
        (await repo.watchDonations().first).map((d) => d.id), isNot(contains(id)));
  });

  test('expenses, events, assets and services all edit and delete', () async {
    final expenseId = await repo.recordExpense(
      branchId: branchId,
      category: 'Utilities',
      vendor: 'ECG',
      amount: 300,
      date: DateTime.utc(2026, 5, 3),
      status: ExpenseStatus.pending,
    );
    await repo.updateExpense(expenseId, status: ExpenseStatus.approved);
    expect(
      (await repo.watchExpenses().first)
          .firstWhere((e) => e.id == expenseId)
          .status,
      ExpenseStatus.approved,
    );
    await repo.deleteExpense(expenseId);
    expect((await repo.watchExpenses().first), isEmpty);

    final eventId = await repo.createEvent(
      branchId: branchId,
      title: 'Convention',
      category: EventCategory.conference,
      startsAt: DateTime.utc(2026, 9, 1, 10),
      endsAt: DateTime.utc(2026, 9, 1, 13),
    );
    await repo.updateEvent(eventId, title: 'Annual Convention');
    expect(
      (await repo.watchEvents().first).firstWhere((e) => e.id == eventId).title,
      'Annual Convention',
    );
    await repo.deleteEvent(eventId);
    expect((await repo.watchEvents().first), isEmpty);

    final assetId = await repo.createAsset(
      branchId: branchId,
      name: 'Keyboard',
      category: 'Instruments',
      condition: AssetCondition.good,
      purchasedAt: DateTime.utc(2024, 1, 1),
      value: 5000,
    );
    await repo.updateAsset(assetId, condition: AssetCondition.fair);
    expect(
      (await repo.watchAssets().first)
          .firstWhere((a) => a.id == assetId)
          .condition,
      AssetCondition.fair,
    );
    await repo.deleteAsset(assetId);
    expect((await repo.watchAssets().first), isEmpty);

    final serviceId = await repo.recordAttendance(
      branchId: branchId,
      date: DateTime.utc(2026, 5, 3),
      serviceName: 'First Service',
      adults: 100,
    );
    await repo.updateAttendanceRecord(serviceId, adults: 120);
    expect(
      (await repo.watchAttendance().first)
          .firstWhere((r) => r.id == serviceId)
          .adults,
      120,
    );
    await repo.deleteAttendanceRecord(serviceId);
    expect((await repo.watchAttendance().first), isEmpty);
  });

  test('headquarters cannot be deleted', () async {
    // A fresh database, because the seeder claims the first branch id and would
    // collide with the branch the other tests build.
    final fresh = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(fresh.close);
    final freshRepo = ChurchRepository(fresh);
    await Seeder(fresh).seedFirstRun();

    final hq = (await freshRepo.watchBranches().first)
        .firstWhere((b) => b.isHeadquarters)
        .id;

    await freshRepo.deleteBranch(hq);

    expect(
      (await freshRepo.watchBranches().first).map((b) => b.id),
      contains(hq),
      reason: 'every record needs a branch to belong to',
    );
  });

  test('a deleted branch leaves the list', () async {
    await repo.deleteBranch(branchId);
    expect((await repo.watchBranches().first).map((b) => b.id),
        isNot(contains(branchId)));
  });
}
