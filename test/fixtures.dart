import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';

/// Test data builders.
///
/// The app no longer ships a demo congregation — a fresh database has one admin
/// account, one headquarters branch and the department catalogue, nothing more.
/// Tests that need members, branches or giving therefore create their own,
/// which is better anyway: each test states the data it depends on instead of
/// relying on a seed it does not control.
class Fixtures {
  Fixtures(this.db) : repo = ChurchRepository(db);

  final AppDatabase db;
  final ChurchRepository repo;

  /// Creates a branch and returns its id.
  Future<String> branch({
    String name = 'Test Branch',
    String code = 'TST',
    String city = 'Accra',
    String state = 'Greater Accra',
    BranchStatus status = BranchStatus.active,
    AccentToken accent = AccentToken.blue,
  }) =>
      repo.createBranch(
        name: name,
        code: code,
        addressLine: '1 Test Road',
        city: city,
        state: state,
        status: status,
        establishedAt: DateTime.utc(2020, 1, 1),
        accent: accent,
      );

  /// Creates a member of [branchId] and returns their id.
  ///
  /// [age] drives the date of birth, so a test can ask for a child or an adult
  /// without computing dates itself.
  Future<String> member({
    required String branchId,
    String firstName = 'Ama',
    String lastName = 'Mensah',
    int age = 30,
    Gender gender = Gender.female,
    MemberStatus status = MemberStatus.active,
    bool isBaptized = true,
  }) {
    final now = DateTime.now().toUtc();
    return repo.createMember(
      branchId: branchId,
      firstName: firstName,
      lastName: lastName,
      email: '${firstName.toLowerCase()}.${lastName.toLowerCase()}'
          '${now.microsecondsSinceEpoch}@example.com',
      phone: '+233 24 000 0000',
      gender: gender,
      dateOfBirth: DateTime.utc(now.year - age, 6, 15),
      maritalStatus: MaritalStatus.single,
      status: status,
      joinedAt: DateTime.utc(now.year - 1, 1, 1),
      addressLine: '2 Member Street',
      city: 'Accra',
      state: 'Greater Accra',
      isBaptized: isBaptized,
    );
  }

  /// Creates several members of one branch and returns their ids.
  Future<List<String>> members({
    required String branchId,
    int count = 3,
    int age = 30,
  }) async {
    final ids = <String>[];
    for (var i = 0; i < count; i++) {
      ids.add(await member(
        branchId: branchId,
        firstName: 'Member$i',
        lastName: 'Test',
        age: age,
      ));
    }
    return ids;
  }

  /// Creates a user account and returns its id.
  Future<String> user({
    required UserRole role,
    String? branchId,
    String? departmentId,
    String name = 'Test User',
    String? email,
    String password = 'testpass1',
    bool? canSeeAllBranches,
  }) =>
      repo.createUser(
        name: name,
        email: email ??
            '${role.name}.${DateTime.now().microsecondsSinceEpoch}@example.com',
        password: password,
        role: role,
        branchId: branchId,
        departmentId: departmentId,
        canSeeAllBranches: canSeeAllBranches,
      );

  /// Creates a department instance at [branchId] from a catalogue type.
  Future<String> department({
    required String branchId,
    required String headId,
    String typeId = 'dpt-worship',
    Weekday meetingDay = Weekday.thursday,
    String meetingTime = '6:00 PM',
  }) =>
      repo.createDepartment(
        typeId: typeId,
        branchId: branchId,
        headId: headId,
        meetingDay: meetingDay,
        meetingTime: meetingTime,
      );

  /// A branch with a handful of adult members — the common starting point.
  Future<({String branchId, List<String> memberIds})> populatedBranch({
    String name = 'Test Branch',
    String code = 'TST',
    int memberCount = 3,
  }) async {
    final id = await branch(name: name, code: code);
    final ids = await members(branchId: id, count: memberCount);
    return (branchId: id, memberIds: ids);
  }
}
