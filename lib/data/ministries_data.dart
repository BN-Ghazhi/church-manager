import '../models/models.dart';
import 'branches_data.dart';
import 'members_data.dart';
import 'seed.dart';

final List<Ministry> ministries = [
  Ministry(
    id: Seed.id('min', 0),
    name: 'Worship & Choir',
    description:
        'Leads congregational worship across all services and midweek rehearsals.',
    leaderId: members[4].id,
    memberCount: 38,
    meetingDay: Weekday.thursday,
    meetingTime: '6:00 PM',
    branchId: hqBranchId,
    accent: AccentToken.violet,
  ),
  Ministry(
    id: Seed.id('min', 1),
    name: 'Ushering & Protocol',
    description:
        'Welcomes, seats and guides the congregation; manages offering flow.',
    leaderId: members[9].id,
    memberCount: 24,
    meetingDay: Weekday.saturday,
    meetingTime: '4:00 PM',
    branchId: hqBranchId,
    accent: AccentToken.blue,
  ),
  Ministry(
    id: Seed.id('min', 2),
    name: "Children's Church",
    description:
        'Age-graded Sunday school, holiday clubs and child safeguarding.',
    leaderId: members[14].id,
    memberCount: 19,
    meetingDay: Weekday.sunday,
    meetingTime: '8:30 AM',
    branchId: hqBranchId,
    accent: AccentToken.amber,
  ),
  Ministry(
    id: Seed.id('min', 3),
    name: 'Media & Technical',
    description: 'Livestream, sound, lighting, slides and service recordings.',
    leaderId: members[21].id,
    memberCount: 15,
    meetingDay: Weekday.friday,
    meetingTime: '5:30 PM',
    branchId: hqBranchId,
    accent: AccentToken.cyan,
  ),
  Ministry(
    id: Seed.id('min', 4),
    name: 'Evangelism & Outreach',
    description:
        'Community outreach, street evangelism and follow-up of new converts.',
    leaderId: members[27].id,
    memberCount: 31,
    meetingDay: Weekday.wednesday,
    meetingTime: '6:30 PM',
    branchId: hqBranchId,
    accent: AccentToken.emerald,
  ),
  Ministry(
    id: Seed.id('min', 5),
    name: 'Prayer & Intercession',
    description:
        'Early morning prayer, vigils and intercession for the church body.',
    leaderId: members[33].id,
    memberCount: 27,
    meetingDay: Weekday.tuesday,
    meetingTime: '5:00 AM',
    branchId: hqBranchId,
    accent: AccentToken.rose,
  ),
];

Ministry? ministryById(String id) =>
    ministries.where((m) => m.id == id).firstOrNull;

const _areas = [
  'Adabraka', 'Osu', 'East Legon', 'Dansoman',
  'Achimota', 'Madina', 'Spintex', 'Adenta',
];

const _groupDays = [
  Weekday.tuesday, Weekday.wednesday, Weekday.thursday, Weekday.friday,
];

final List<SmallGroup> smallGroups = List.generate(8, (i) {
  return SmallGroup(
    id: Seed.id('grp', i),
    name: '${_areas[i]} Home Cell',
    leaderId: members[i * 6 + 2].id,
    memberCount: Seed.intIn(i * 9, 8, 26),
    location: '${_areas[i]}, Accra',
    meetingDay: Seed.pick(_groupDays, i),
    meetingTime: '7:00 PM',
    branchId: branchIdAt(i % branchSeeds.length),
    capacity: 30,
  );
});

SmallGroup? groupById(String id) =>
    smallGroups.where((g) => g.id == id).firstOrNull;

/// Four upcoming Sundays × every serving role.
final List<VolunteerSlot> volunteerSlots = List.generate(28, (i) {
  final week = i ~/ ServingRole.values.length;
  final role = ServingRole.values[i % ServingRole.values.length];
  final isFilled = i % 5 != 0;

  return VolunteerSlot(
    id: Seed.id('slot', i),
    date: dayOnly(3 + week * 7),
    serviceName: week.isEven ? 'First Service' : 'Second Service',
    branchId: branchIdAt(i % branchSeeds.length),
    role: role,
    memberId: isFilled ? members[(i * 5 + 7) % members.length].id : null,
    status: isFilled
        ? SlotStatus.filled
        : (i % 10 == 5 ? SlotStatus.declined : SlotStatus.open),
  );
});

final List<Course> courses = [
  Course(
    id: Seed.id('crs', 0),
    name: 'Foundations of Faith',
    description:
        'Six-week new believers class covering salvation, baptism and the Word.',
    lessons: 6,
    enrolled: 42,
    completed: 28,
    branchId: hqBranchId,
    facilitatorId: members[2].id,
  ),
  Course(
    id: Seed.id('crs', 1),
    name: 'Membership Class',
    description: 'Church vision, structure, giving and covenant membership.',
    lessons: 4,
    enrolled: 35,
    completed: 31,
    branchId: hqBranchId,
    facilitatorId: members[8].id,
  ),
  Course(
    id: Seed.id('crs', 2),
    name: 'Leadership Development',
    description:
        'Character, competence and team leadership for emerging leaders.',
    lessons: 10,
    enrolled: 18,
    completed: 7,
    branchId: branchIdAt(1),
    facilitatorId: members[13].id,
  ),
  Course(
    id: Seed.id('crs', 3),
    name: 'Marriage & Family',
    description:
        'Pre-marital and marital counselling curriculum for couples.',
    lessons: 8,
    enrolled: 24,
    completed: 15,
    branchId: branchIdAt(2),
    facilitatorId: members[19].id,
  ),
];
