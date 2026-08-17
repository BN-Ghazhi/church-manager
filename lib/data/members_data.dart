import '../models/models.dart';
import 'branches_data.dart';
import 'seed.dart';

const _firstNames = [
  // Christian names in common use
  'Grace', 'Samuel', 'Esther', 'Daniel', 'Ruth', 'Emmanuel', 'Comfort',
  'Joshua', 'Naomi', 'Isaac', 'Deborah', 'Michael', 'Hannah', 'Gideon',
  'Abigail', 'Elijah', 'Priscilla', 'Timothy', 'Lydia', 'Stephen', 'Rebecca',
  // Akan
  'Kwame', 'Kwesi', 'Kofi', 'Yaw', 'Kwabena', 'Kojo', 'Akwasi',
  'Akosua', 'Adwoa', 'Abena', 'Yaa', 'Afua', 'Ama', 'Akua',
  'Nana', 'Kwaku', 'Afia', 'Adjoa',
  // Ewe
  'Elikem', 'Dzifa', 'Mawuli', 'Akpene', 'Senyo', 'Yayra',
  // Ga
  'Nii', 'Naa', 'Tetteh', 'Ayikai',
  // Dagbani / northern
  'Fuseini', 'Alhassan', 'Mariama', 'Abdulai',
];

const _lastNames = [
  // Akan
  'Mensah', 'Boateng', 'Owusu', 'Asante', 'Osei', 'Agyemang', 'Frimpong',
  'Amoah', 'Appiah', 'Bediako', 'Darko', 'Gyasi', 'Nkrumah', 'Ofori',
  'Sarpong', 'Yeboah', 'Antwi', 'Danso',
  // Ga / Dangme
  'Quartey', 'Tetteh', 'Lartey', 'Ankrah', 'Nortey', 'Addo',
  // Ewe
  'Agbeko', 'Dogbe', 'Adjei', 'Amegashie', 'Fiadzo',
  // Northern
  'Abdulai', 'Mahama', 'Sulemana',
];

const _cities = [
  ['Accra', 'Greater Accra'],
  ['Tema', 'Greater Accra'],
  ['Kumasi', 'Ashanti'],
  ['Takoradi', 'Western'],
  ['Tamale', 'Northern'],
  ['Cape Coast', 'Central'],
  ['Koforidua', 'Eastern'],
  ['Sunyani', 'Bono'],
];

const _streets = [
  'Independence', 'Liberation', 'Ring Road', 'Oxford', 'Castle',
  'Cantonments', 'Bethel', 'Harper',
];

const _statuses = [
  MemberStatus.active, MemberStatus.active, MemberStatus.active,
  MemberStatus.active, MemberStatus.active, MemberStatus.active,
  MemberStatus.active, MemberStatus.visitor, MemberStatus.inactive,
  MemberStatus.transferred,
];

const _maritalStatuses = [
  MaritalStatus.single, MaritalStatus.married, MaritalStatus.married,
  MaritalStatus.widowed, MaritalStatus.divorced,
];

const _tags = [
  'New convert', 'Choir', 'Tither', 'Bible study', 'Youth', 'Leadership track',
  'First timer', 'Media team', 'Intercessor', 'Sunday school teacher',
];

/// 240 deterministic members spread across the branches — enough for every
/// branch to have a believable roll, and to exercise search, filters and paging.
final List<Member> members = List.generate(240, (i) {
  final first = Seed.pick(_firstNames, i * 7 + 1);
  final last = Seed.pick(_lastNames, i * 11 + 3);
  final city = Seed.pick(_cities, i * 5);

  // Every 6th record is a child or teenager, so the age distribution looks like
  // a real congregation rather than an adults-only directory. Children are kept
  // at least 2 years old so nobody ends up shown as an infant.
  final birthYear = i % 6 == 0
      ? 2009 + Seed.intIn(i * 3, 0, 15)
      : 1958 + Seed.intIn(i * 3, 0, 48);

  final dateOfBirth = DateTime.utc(
    birthYear,
    Seed.intIn(i * 29, 1, 12),
    Seed.intIn(i * 31, 1, 28),
  );

  // A member cannot join before they were born. Comparing whole years is not
  // enough — someone born in December of their join year would still slip
  // through — so the candidate date is clamped against the actual birthday.
  final earliestJoinYear = birthYear > 2009 ? birthYear : 2009;
  final joinYear =
      earliestJoinYear + Seed.intIn(i * 13, 0, 2025 - earliestJoinYear);
  final candidateJoin = DateTime.utc(
    joinYear,
    Seed.intIn(i * 37, 1, 12),
    Seed.intIn(i * 41, 1, 28),
  );
  final joinedAt = candidateJoin.isBefore(dateOfBirth)
      ? DateTime.utc(dateOfBirth.year + 1, dateOfBirth.month, dateOfBirth.day)
      : candidateJoin;

  final branchId = branchForMemberIndex(i);

  final tagA = Seed.pick(_tags, i * 3);
  final tagB = Seed.pick(_tags, i * 5 + 1);

  return Member(
    id: Seed.id('mem', i),
    firstName: first,
    lastName: last,
    email: '${first.toLowerCase()}.${last.toLowerCase()}@example.com',
    phone: '+233 ${Seed.pick(const ['24', '20', '54', '55', '27', '57'], i * 17)}'
        ' ${Seed.intIn(i * 19, 100, 999)} ${Seed.intIn(i * 23, 1000, 9999)}',
    gender: i.isEven ? Gender.female : Gender.male,
    dateOfBirth: dateOfBirth,
    maritalStatus: Seed.pick(_maritalStatuses, i * 3),
    status: Seed.pick(_statuses, i),
    joinedAt: joinedAt,
    address: Address(
      line1: '${Seed.intIn(i * 43, 1, 240)} ${Seed.pick(_streets, i)} Street',
      city: city[0],
      state: city[1],
    ),
    isBaptized: i % 7 != 0,
    branchId: branchId,
    ministryIds: i % 3 == 0
        ? [Seed.id('min', i % 6)]
        : i % 5 == 0
            ? [Seed.id('min', i % 6), Seed.id('min', (i + 2) % 6)]
            : const [],
    groupId: i % 4 == 0 ? Seed.id('grp', i % 8) : null,
    familyId: i % 3 == 0 ? Seed.id('fam', (i ~/ 3) % 18) : null,
    notes: i % 9 == 0
        ? 'Follow up after last counselling session.'
        : null,
    tags: tagA == tagB ? [tagA] : [tagA, tagB],
  );
});

final Map<String, Member> _byId = {for (final m in members) m.id: m};

Member? memberById(String id) => _byId[id];

/// Display name for an id, safe against missing or null references.
String memberName(String? id) {
  if (id == null) return 'Unassigned';
  return _byId[id]?.fullName ?? 'Unknown';
}

final List<Family> families = List.generate(18, (i) {
  final id = Seed.id('fam', i);
  final household = members.where((m) => m.familyId == id).toList();
  final head = household.isNotEmpty ? household.first : members[i];
  return Family(
    id: id,
    name: 'The ${head.lastName} Family',
    headMemberId: head.id,
    memberIds: household.map((m) => m.id).toList(),
    branchId: head.branchId,
    address: head.address,
  );
});

/// Members whose home branch is [branchId].
List<Member> membersOfBranch(String branchId) =>
    members.where((m) => m.branchId == branchId).toList();
