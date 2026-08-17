import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// A record you have just added must appear at the top of its list, not buried
/// at the bottom. These tests pin that for every list where it matters.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late String branchId;
  late String memberId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);

    branchId = await repo.createBranch(
      name: 'Accra', code: 'ACC', addressLine: '1 Ring Road',
      city: 'Accra', state: 'Greater Accra', status: BranchStatus.active,
      establishedAt: DateTime.utc(2020, 1, 1), accent: AccentToken.blue,
    );
    memberId = await repo.createMember(
      branchId: branchId, firstName: 'Ama', lastName: 'Mensah',
      email: 'ama@example.com', phone: '+233 24 000 0000',
      gender: Gender.female, dateOfBirth: DateTime.utc(1990, 1, 1),
      maritalStatus: MaritalStatus.single, status: MemberStatus.active,
      joinedAt: DateTime.utc(2021, 1, 1), addressLine: '1 Road',
      city: 'Accra', state: 'Greater Accra', isBaptized: true,
    );
  });

  tearDown(() => db.close());

  test('the newest donation leads, even sharing a date with others', () async {
    final sameDay = DateTime.utc(2026, 8, 10);

    for (final name in ['First', 'Second', 'Third']) {
      await repo.recordDonation(
        branchId: branchId, donorName: name, amount: 1000,
        fund: GivingFund.tithe, method: PaymentMethod.cash, date: sameDay,
      );
      // createdAt has second precision, so separate the writes.
      await Future<void>.delayed(const Duration(milliseconds: 1100));
    }

    final ledger = await repo.watchDonations().first;
    expect(ledger.first.donorName, 'Third',
        reason: 'the most recently entered gift must be at the top');
  });

  test('a back-dated donation does not hide at the bottom of its date', () async {
    await repo.recordDonation(
      branchId: branchId, donorName: 'Recent', amount: 1000,
      fund: GivingFund.tithe, method: PaymentMethod.cash,
      date: DateTime.utc(2026, 8, 15),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    await repo.recordDonation(
      branchId: branchId, donorName: 'BackDated', amount: 1000,
      fund: GivingFund.tithe, method: PaymentMethod.cash,
      date: DateTime.utc(2026, 8, 1),
    );

    final ledger = await repo.watchDonations().first;
    // The newer business date still leads — a ledger is ordered by when the
    // money moved, not when it was typed.
    expect(ledger.first.donorName, 'Recent');
    // But the back-dated one is present and findable, not lost.
    expect(ledger.map((d) => d.donorName), contains('BackDated'));
  });

  test('the newest expense leads', () async {
    final day = DateTime.utc(2026, 8, 12);
    for (final vendor in ['Alpha', 'Beta']) {
      await repo.recordExpense(
        branchId: branchId, category: 'Utilities', vendor: vendor,
        amount: 500, date: day, status: ExpenseStatus.pending,
      );
      await Future<void>.delayed(const Duration(milliseconds: 1100));
    }
    final list = await repo.watchExpenses().first;
    expect(list.first.vendor, 'Beta');
  });

  test('the newest asset leads', () async {
    for (final name in ['Old Mixer', 'New Mixer']) {
      await repo.createAsset(
        branchId: branchId, name: name, category: 'Audio',
        condition: AssetCondition.good,
        purchasedAt: DateTime.utc(2024, 1, 1), value: 1000,
      );
      await Future<void>.delayed(const Duration(milliseconds: 1100));
    }
    final list = await repo.watchAssets().first;
    expect(list.first.name, 'New Mixer');
  });

  test('the newest course leads', () async {
    for (final name in ['Foundations', 'Leadership']) {
      await repo.createCourse(
        branchId: branchId, name: name, description: '', lessons: 4,
      );
      await Future<void>.delayed(const Duration(milliseconds: 1100));
    }
    final list = await repo.watchCourses().first;
    expect(list.first.name, 'Leadership');
  });

  test('the newest care request leads', () async {
    for (final summary in ['Older need', 'Newer need']) {
      await repo.createCareRequest(
        branchId: branchId, memberId: memberId, type: CareType.prayer,
        summary: summary, priority: CarePriority.medium,
      );
      await Future<void>.delayed(const Duration(milliseconds: 1100));
    }
    final list = await repo.watchCareRequests().first;
    expect(list.first.summary, 'Newer need');
  });

  test('the newest attendance record for a date leads', () async {
    final day = DateTime.utc(2026, 8, 16);
    await repo.recordAttendance(
      branchId: branchId, date: day, serviceName: 'First Service',
      adults: 10, children: 0, visitors: 0, online: 0,
    );
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    await repo.recordAttendance(
      branchId: branchId, date: day, serviceName: 'Second Service',
      adults: 20, children: 0, visitors: 0, online: 0,
    );

    final list = await repo.watchAttendance().first;
    expect(list.first.serviceName, 'Second Service');
  });

  test('the newest department leads within its branch', () async {
    final typeA = await repo.createDepartmentType(
      name: 'Worship', description: '', icon: 'worship',
      accent: AccentToken.rose,
    );
    final typeB = await repo.createDepartmentType(
      name: 'Media', description: '', icon: 'media',
      accent: AccentToken.cyan,
    );

    await repo.createDepartment(
      typeId: typeA, branchId: branchId, headId: memberId,
      meetingDay: Weekday.thursday, meetingTime: '6:00 PM',
    );
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    final newer = await repo.createDepartment(
      typeId: typeB, branchId: branchId, headId: memberId,
      meetingDay: Weekday.friday, meetingTime: '5:00 PM',
    );

    final list = await repo.watchDepartments().first;
    expect(list.first.id, newer);
  });
}
