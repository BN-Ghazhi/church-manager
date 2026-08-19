import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// "How do we know if a member was present?" — these prove the two reads that
/// answer it: the people at one service, and one person's services.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late Fixtures fx;
  late String branchId;
  late String present;
  late String absent;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    fx = Fixtures(db);
    branchId = await fx.branch();
    present = await fx.member(branchId: branchId);
    absent = await fx.member(branchId: branchId);
  });

  tearDown(() => db.close());

  test('a checked-in member shows up against that service', () async {
    await repo.saveCheckIns(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 2),
      serviceName: 'First Service',
      memberIds: {present},
    );

    final service = (await repo.watchAttendance().first).single;
    final attendees =
        await repo.watchServiceAttendees(service.id).first;

    expect(attendees.map((m) => m.id), [present]);
    expect(attendees.map((m) => m.id), isNot(contains(absent)));
  });

  test("a member's own history lists every service they attended", () async {
    for (final day in [2, 9, 16]) {
      await repo.saveCheckIns(
        branchId: branchId,
        date: DateTime.utc(2026, 8, day),
        serviceName: 'First Service',
        memberIds: {present},
      );
    }

    final history = await repo.watchMemberAttendance(present).first;
    expect(history, hasLength(3));
    // Newest first, so "when were they last in church" is the top row.
    expect(history.first.date, DateTime.utc(2026, 8, 16));

    expect(await repo.watchMemberAttendance(absent).first, isEmpty);
  });

  test('the attendance rate counts services, not just check-ins', () async {
    // Three services held; the member came to two of them.
    for (final day in [2, 9, 16]) {
      await repo.recordAttendance(
        branchId: branchId,
        date: DateTime.utc(2026, 8, day),
        serviceName: 'First Service',
        adults: 50,
      );
    }
    for (final day in [2, 16]) {
      await repo.saveCheckIns(
        branchId: branchId,
        date: DateTime.utc(2026, 8, day),
        serviceName: 'First Service',
        memberIds: {present},
      );
    }

    final rate = await repo.attendanceRate(present, branchId: branchId);
    expect(rate.total, 3);
    expect(rate.attended, 2);

    final none = await repo.attendanceRate(absent, branchId: branchId);
    expect(none.attended, 0);
    expect(none.total, 3);
  });

  test('a service with only a headcount has no names against it', () async {
    final id = await repo.recordAttendance(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 23),
      serviceName: 'Second Service',
      adults: 200,
    );

    expect(await repo.watchServiceAttendees(id).first, isEmpty);
  });
}
