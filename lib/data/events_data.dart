import '../models/models.dart';
import 'branches_data.dart';
import 'members_data.dart';
import 'seed.dart';

class _EventSeed {
  const _EventSeed(this.title, this.category, this.location, this.dayOffset,
      this.hour, this.hours, this.recurring);

  final String title;
  final EventCategory category;
  final String location;
  final int dayOffset;
  final int hour;
  final int hours;
  final bool recurring;
}

const _seeds = [
  _EventSeed('Sunday First Service', EventCategory.service, 'Main Auditorium', 3, 7, 2, true),
  _EventSeed('Sunday Second Service', EventCategory.service, 'Main Auditorium', 3, 10, 2, true),
  _EventSeed('Choir Rehearsal', EventCategory.rehearsal, 'Music Room', 1, 18, 2, true),
  _EventSeed('Midweek Bible Study', EventCategory.service, 'Main Auditorium', 6, 18, 2, true),
  _EventSeed("Leaders' Council", EventCategory.meeting, 'Board Room', 8, 17, 2, false),
  _EventSeed('Community Medical Outreach', EventCategory.outreach, 'Adabraka Community Centre', 12, 9, 6, false),
  _EventSeed('Youth Hangout & Games', EventCategory.youth, 'Church Grounds', 16, 15, 4, false),
  _EventSeed('All-Night Prayer Vigil', EventCategory.prayer, 'Main Auditorium', 19, 22, 6, true),
  _EventSeed('Annual Leadership Conference', EventCategory.conference, 'Accra International Conference Centre', 24, 9, 8, false),
  _EventSeed("Children's Holiday Club", EventCategory.youth, "Children's Hall", 27, 10, 4, false),
  _EventSeed('Media Team Training', EventCategory.meeting, 'Studio', 30, 16, 3, false),
  _EventSeed('Marriage Seminar', EventCategory.conference, 'Fellowship Hall', 34, 11, 4, false),
  _EventSeed("Ushers' Debrief", EventCategory.meeting, 'Room 2', -4, 17, 1, true),
  _EventSeed('Street Evangelism', EventCategory.outreach, 'Makola Market', -9, 8, 4, false),
];

final List<ChurchEvent> events = List.generate(_seeds.length, (i) {
  final s = _seeds[i];
  return ChurchEvent(
    id: Seed.id('evt', i),
    title: s.title,
    description:
        '${s.title} — organised by the church calendar team. All are welcome.',
    category: s.category,
    startsAt: atHour(s.dayOffset, s.hour),
    endsAt: atHour(s.dayOffset, s.hour + s.hours),
    location: s.location,
    organizerId: members[(i * 6 + 3) % members.length].id,
    expectedAttendance: Seed.intIn(i * 7, 40, 900),
    registeredCount: Seed.intIn(i * 11, 20, 700),
    branchId: branchIdAt(i % branchSeeds.length),
    isRecurring: s.recurring,
  );
});

/// Events from today onward, soonest first.
List<ChurchEvent> upcomingEvents() {
  final today = DateTime.utc(kDemoNow.year, kDemoNow.month, kDemoNow.day);
  return events.where((e) => !e.startsAt.isBefore(today)).toList()
    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
}

/// 26 weeks of Sunday attendance for every branch, most recent first.
///
/// Branch size scales the headcount, so HQ reads as the largest congregation
/// and the church plant as the smallest — the totals stay believable when the
/// dashboard consolidates them.
final List<AttendanceRecord> attendanceRecords = () {
  final result = <AttendanceRecord>[];
  for (var b = 0; b < branchSeeds.length; b++) {
    final scale = [1.0, 0.62, 0.48, 0.4, 0.3, 0.14][b];
    for (var i = 0; i < 26; i++) {
      final seed = b * 100 + i;
      result.add(AttendanceRecord(
        id: Seed.id('att', seed),
        date: dayOnly(-3 - i * 7),
        serviceName: i.isEven ? 'First Service' : 'Second Service',
        branchId: branchIdAt(b),
        adults: ((420 + Seed.intIn(seed * 13, -70, 110)) * scale).round(),
        children: ((95 + Seed.intIn(seed * 17, -25, 45)) * scale).round(),
        visitors: ((18 + Seed.intIn(seed * 19, -10, 30)) * scale).round(),
        online: ((240 + Seed.intIn(seed * 23, -80, 190)) * scale).round(),
      ));
    }
  }
  result.sort((a, b) => b.date.compareTo(a.date));
  return result;
}();

/// In-person vs. online for the last twelve service dates, oldest first.
///
/// Records are summed per date so the trend reflects whichever branches are in
/// scope, rather than one branch's numbers standing in for the whole church.
List<TrendPoint> attendanceTrendFor(List<AttendanceRecord> records) {
  final byDate = <DateTime, List<AttendanceRecord>>{};
  for (final r in records) {
    byDate.putIfAbsent(r.date, () => []).add(r);
  }
  final dates = byDate.keys.toList()..sort();
  final recent = dates.length <= 12 ? dates : dates.sublist(dates.length - 12);

  return [
    for (final date in recent)
      TrendPoint(
        label: '${date.month}/${date.day}',
        value: byDate[date]!.fold<double>(0, (s, r) => s + r.inPerson),
        compare: byDate[date]!.fold<double>(0, (s, r) => s + r.online),
      ),
  ];
}

final List<TrendPoint> attendanceTrend = attendanceTrendFor(attendanceRecords);

const _announcementSeeds = [
  [
    'Sanctuary project reaches 62% of target',
    'Thank you church! The building committee will share a full breakdown at the next members\' meeting.'
  ],
  [
    'New members\' class starts Sunday',
    'If you joined us in the last three months, please register at the welcome desk after service.'
  ],
  [
    'Choir auditions open',
    'Auditions hold every Thursday in the music room from 6:00 PM. Bring a song of your choice.'
  ],
  [
    'Car park reconstruction',
    'The west car park will be closed for two weeks. Please use the school field entrance.'
  ],
  [
    'Harvest thanksgiving date confirmed',
    'This year\'s harvest holds on the last Sunday of November. Committees will be announced shortly.'
  ],
  [
    'Medical outreach volunteers needed',
    'We need 30 volunteers — nurses, pharmacists and logistics support. Sign up with your unit leader.'
  ],
];

final List<AnnouncementItem> announcements =
    List.generate(_announcementSeeds.length, (i) {
  return AnnouncementItem(
    id: Seed.id('ann', i),
    title: _announcementSeeds[i][0],
    body: _announcementSeeds[i][1],
    postedAt: atHour(-i * 2 - 1, 10),
    authorId: members[(i * 8 + 1) % members.length].id,
    branchId: branchIdAt(i % branchSeeds.length),
    pinned: i < 2,
  );
});
