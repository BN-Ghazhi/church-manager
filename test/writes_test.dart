import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Proves the create/record paths actually persist, and that a saved record
/// comes back with the values it was given.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late String branchId;
  late String memberId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);

    branchId = await repo.createBranch(
      name: 'Test Branch',
      code: 'TST',
      addressLine: '1 Test Road',
      city: 'Accra',
      state: 'Greater Accra',
      status: BranchStatus.active,
      establishedAt: DateTime.utc(2020, 1, 1),
      accent: AccentToken.blue,
    );

    memberId = await repo.createMember(
      branchId: branchId,
      firstName: 'Grace',
      lastName: 'Test',
      email: 'grace.test@example.com',
      phone: '+233 24 000 0000',
      gender: Gender.female,
      dateOfBirth: DateTime.utc(1990, 5, 20),
      maritalStatus: MaritalStatus.single,
      status: MemberStatus.active,
      joinedAt: DateTime.utc(2021, 3, 1),
      addressLine: '2 Member Street',
      city: 'Accra',
      state: 'Greater Accra',
      isBaptized: true,
    );
  });

  tearDown(() => db.close());

  test('a recorded donation persists with its values', () async {
    await repo.recordDonation(
      branchId: branchId,
      memberId: memberId,
      donorName: 'Grace Test',
      amount: 50000,
      fund: GivingFund.building,
      method: PaymentMethod.transfer,
      date: DateTime.utc(2026, 8, 1),
    );

    final saved = await repo.watchDonations().first;
    expect(saved, hasLength(1));
    expect(saved.first.amount, 50000);
    expect(saved.first.fund, GivingFund.building);
    expect(saved.first.branchId, branchId);
    expect(saved.first.memberId, memberId);
    // A reference is generated when none is supplied.
    expect(saved.first.reference, isNotEmpty);
  });

  test('a recorded expense persists', () async {
    await repo.recordExpense(
      branchId: branchId,
      category: 'Utilities',
      vendor: 'Eko Electricity',
      amount: 32000,
      date: DateTime.utc(2026, 8, 2),
      status: ExpenseStatus.pending,
    );

    final saved = await repo.watchExpenses().first;
    expect(saved, hasLength(1));
    expect(saved.first.vendor, 'Eko Electricity');
    expect(saved.first.status, ExpenseStatus.pending);
  });

  test('an attendance record persists and totals correctly', () async {
    await repo.recordAttendance(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 9),
      serviceName: 'First Service',
      adults: 100,
      children: 20,
      visitors: 5,
      online: 30,
    );

    final saved = await repo.watchAttendance().first;
    expect(saved, hasLength(1));
    expect(saved.first.inPerson, 125);
    expect(saved.first.total, 155);
  });

  test('an event persists with its window', () async {
    final start = DateTime.utc(2026, 9, 1, 10);
    await repo.createEvent(
      branchId: branchId,
      title: 'Leaders Council',
      category: EventCategory.meeting,
      startsAt: start,
      endsAt: start.add(const Duration(hours: 2)),
      location: 'Board Room',
      expectedAttendance: 40,
      isRecurring: false,
    );

    final saved = await repo.watchEvents().first;
    expect(saved, hasLength(1));
    expect(saved.first.title, 'Leaders Council');
    expect(saved.first.endsAt.difference(saved.first.startsAt).inHours, 2);
  });

  test('a care request persists and can be resolved', () async {
    final id = await repo.createCareRequest(
      branchId: branchId,
      memberId: memberId,
      type: CareType.hospital,
      summary: 'Requests a visit',
      priority: CarePriority.high,
    );

    var saved = await repo.watchCareRequests().first;
    expect(saved.first.status, CareStatus.open);
    expect(saved.first.priority, CarePriority.high);

    await repo.updateCareRequest(id, status: CareStatus.resolved);
    saved = await repo.watchCareRequests().first;
    expect(saved.first.status, CareStatus.resolved);
  });

  test('an asset persists', () async {
    await repo.createAsset(
      branchId: branchId,
      name: 'Test Mixer',
      category: 'Audio',
      condition: AssetCondition.good,
      purchasedAt: DateTime.utc(2025, 1, 1),
      value: 890000,
    );

    final saved = await repo.watchAssets().first;
    expect(saved, hasLength(1));
    expect(saved.first.name, 'Test Mixer');
    expect(saved.first.value, 890000);
  });

  test('a course persists', () async {
    await repo.createCourse(
      branchId: branchId,
      name: 'Foundations',
      description: 'New believers',
      lessons: 6,
    );

    final saved = await repo.watchCourses().first;
    expect(saved, hasLength(1));
    expect(saved.first.lessons, 6);
  });

  test('branch leadership can only be a member of that branch', () async {
    final otherBranch = await repo.createBranch(
      name: 'Other Branch',
      code: 'OTH',
      addressLine: '9 Other Road',
      city: 'Kumasi',
      state: 'Ashanti',
      status: BranchStatus.active,
      establishedAt: DateTime.utc(2022, 1, 1),
      accent: AccentToken.rose,
    );

    await repo.setBranchLeadership(otherBranch, pastorId: memberId);
    final branches = await repo.watchBranches().first;
    final other = branches.firstWhere((b) => b.id == otherBranch);

    expect(
      other.pastorId,
      isNot(memberId),
      reason: 'a member of another branch must not become its pastor',
    );
  });

  test('a volunteer assignment can be filled, cleared and declined', () async {
    final slotId = await repo.createVolunteerSlot(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 16),
      serviceName: 'First Service',
      role: ServingRole.usher,
    );

    await repo.assignVolunteer(slotId, memberId);
    var slots = await repo.watchVolunteerSlots().first;
    expect(slots.first.status, SlotStatus.filled);
    expect(slots.first.memberId, memberId);

    await repo.assignVolunteer(slotId, null);
    slots = await repo.watchVolunteerSlots().first;
    expect(slots.first.status, SlotStatus.open);
    expect(slots.first.memberId, isNull);

    await repo.assignVolunteer(slotId, memberId,
        status: SlotStatus.declined);
    slots = await repo.watchVolunteerSlots().first;
    expect(slots.first.status, SlotStatus.declined);
  });

  test('department membership rejects other branches and wrong ages', () async {
    final typeId = await repo.createDepartmentType(
      name: 'Children',
      description: 'Ages 0-12',
      icon: 'children',
      accent: AccentToken.amber,
      isCore: true,
      minAge: 0,
      maxAge: 12,
    );

    final deptId = await repo.createDepartment(
      typeId: typeId,
      branchId: branchId,
      headId: memberId,
      meetingDay: Weekday.sunday,
      meetingTime: '8:30 AM',
    );

    // An adult of the right branch: too old for a 0-12 department.
    // A child of another branch: right age, wrong branch.
    final otherBranch = await repo.createBranch(
      name: 'Other', code: 'OTH', addressLine: '1 Rd', city: 'Kumasi',
      state: 'Ashanti', status: BranchStatus.active,
      establishedAt: DateTime.utc(2022, 1, 1), accent: AccentToken.rose,
    );
    final outsideChild = await repo.createMember(
      branchId: otherBranch,
      firstName: 'Ada', lastName: 'Outside',
      email: 'ada@example.com', phone: '+233 24 111 1111',
      gender: Gender.female,
      dateOfBirth: DateTime.now().toUtc().subtract(const Duration(days: 365 * 8)),
      maritalStatus: MaritalStatus.single, status: MemberStatus.active,
      joinedAt: DateTime.utc(2024, 1, 1),
      addressLine: '1 Rd', city: 'Kumasi', state: 'Ashanti', isBaptized: false,
    );

    await repo.setDepartmentMembers(deptId, {memberId, outsideChild});

    final saved = await repo.watchDepartments().first;
    final dept = saved.firstWhere((d) => d.id == deptId);
    expect(dept.memberIds, isEmpty,
        reason: 'an adult and an out-of-branch child must both be rejected');
  });

  test('department leadership must come from the same branch', () async {
    final typeId = await repo.createDepartmentType(
      name: 'Worship', description: 'Music', icon: 'worship',
      accent: AccentToken.violet,
    );
    final deptId = await repo.createDepartment(
      typeId: typeId, branchId: branchId, headId: memberId,
      meetingDay: Weekday.thursday, meetingTime: '6:00 PM',
    );

    final otherBranch = await repo.createBranch(
      name: 'Other2', code: 'OT2', addressLine: '2 Rd', city: 'Takoradi',
      state: 'Western', status: BranchStatus.active,
      establishedAt: DateTime.utc(2022, 1, 1), accent: AccentToken.cyan,
    );
    final outsider = await repo.createMember(
      branchId: otherBranch,
      firstName: 'Sam', lastName: 'Outsider',
      email: 'sam@example.com', phone: '+233 24 222 2222',
      gender: Gender.male, dateOfBirth: DateTime.utc(1985, 1, 1),
      maritalStatus: MaritalStatus.married, status: MemberStatus.active,
      joinedAt: DateTime.utc(2023, 1, 1),
      addressLine: '2 Rd', city: 'Takoradi', state: 'Western', isBaptized: true,
    );

    await repo.setDepartmentLeadership(deptId, headId: outsider);
    final saved = await repo.watchDepartments().first;
    expect(saved.firstWhere((d) => d.id == deptId).headId, isNot(outsider));

    await repo.setDepartmentLeadership(deptId, headId: memberId);
    final ok = await repo.watchDepartments().first;
    expect(ok.firstWhere((d) => d.id == deptId).headId, memberId);
  });

  test('a check-in records that a specific member was present', () async {
    final date = DateTime.utc(2026, 8, 23);

    await repo.saveCheckIns(
      branchId: branchId,
      date: date,
      serviceName: 'First Service',
      memberIds: {memberId},
    );

    // The question headcounts could not answer: was this person there?
    final history = await repo.watchMemberAttendance(memberId).first;
    expect(history, hasLength(1));
    expect(history.single.date, date);
    expect(history.single.serviceName, 'First Service');
  });

  test('a member absent from a service does not appear in their history',
      () async {
    final absentee = await repo.createMember(
      branchId: branchId, firstName: 'Away', lastName: 'Member',
      email: '', phone: '', gender: Gender.male,
      dateOfBirth: DateTime.utc(1988, 1, 1),
      maritalStatus: MaritalStatus.single, status: MemberStatus.active,
      joinedAt: DateTime.utc(2024, 1, 1), addressLine: '', city: '',
      state: '', isBaptized: true,
    );

    await repo.saveCheckIns(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 23),
      serviceName: 'First Service',
      memberIds: {memberId},
    );

    expect(await repo.watchMemberAttendance(absentee).first, isEmpty);
  });

  test('attendance rate counts services attended out of those held', () async {
    for (final day in [16, 23, 30]) {
      await repo.saveCheckIns(
        branchId: branchId,
        date: DateTime.utc(2026, 8, day),
        serviceName: 'First Service',
        // Present for two of the three.
        memberIds: day == 30 ? <String>{} : {memberId},
      );
    }

    final rate = await repo.attendanceRate(memberId, branchId: branchId);
    expect(rate.total, 3);
    expect(rate.attended, 2);
  });
}