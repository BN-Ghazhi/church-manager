import 'package:flutter/material.dart';
// Riverpod exports a `Family` type of its own; hide it so the domain model's
// `Family` (a household) is the one in scope here.
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../aggregates/dashboard.dart' as dash;
import '../aggregates/attendance.dart' as ev;
import '../aggregates/finance.dart' as fin;
import '../config/permissions.dart' as ops;
import '../models/models.dart';
import 'auth.dart';
import 'permissions.dart';

/* ------------------------------------------------------------- raw sources */

/// Live tables straight from the database. Everything below derives from these,
/// so a write anywhere re-runs every dependent provider automatically — the UI
/// updates itself without a manual refresh.
final branchesStreamProvider = StreamProvider<List<Branch>>(
  (ref) => ref.watch(repositoryProvider).watchBranches(),
);
final membersStreamProvider = StreamProvider<List<Member>>(
  (ref) => ref.watch(repositoryProvider).watchMembers(),
);
final departmentTypesStreamProvider = StreamProvider<List<DepartmentType>>(
  (ref) => ref.watch(repositoryProvider).watchDepartmentTypes(),
);
final departmentsStreamProvider = StreamProvider<List<Department>>(
  (ref) => ref.watch(repositoryProvider).watchDepartments(),
);
final usersStreamProvider = StreamProvider<List<StaffUser>>(
  (ref) => ref.watch(repositoryProvider).watchUsers(),
);
final attendanceStreamProvider = StreamProvider<List<AttendanceRecord>>(
  (ref) => ref.watch(repositoryProvider).watchAttendance(),
);
final donationsStreamProvider = StreamProvider<List<Donation>>(
  (ref) => ref.watch(repositoryProvider).watchDonations(),
);
final expensesStreamProvider = StreamProvider<List<ExpenseRecord>>(
  (ref) => ref.watch(repositoryProvider).watchExpenses(),
);
final pledgesStreamProvider = StreamProvider<List<Pledge>>(
  (ref) => ref.watch(repositoryProvider).watchPledges(),
);
final eventsStreamProvider = StreamProvider<List<ChurchEvent>>(
  (ref) => ref.watch(repositoryProvider).watchEvents(),
);
final careStreamProvider = StreamProvider<List<CareRequest>>(
  (ref) => ref.watch(repositoryProvider).watchCareRequests(),
);
final slotsStreamProvider = StreamProvider<List<VolunteerSlot>>(
  (ref) => ref.watch(repositoryProvider).watchVolunteerSlots(),
);
final assetsStreamProvider = StreamProvider<List<AssetItem>>(
  (ref) => ref.watch(repositoryProvider).watchAssets(),
);
final campaignsStreamProvider = StreamProvider<List<Campaign>>(
  (ref) => ref.watch(repositoryProvider).watchCampaigns(),
);
final announcementsStreamProvider = StreamProvider<List<AnnouncementItem>>(
  (ref) => ref.watch(repositoryProvider).watchAnnouncements(),
);
final coursesStreamProvider = StreamProvider<List<Course>>(
  (ref) => ref.watch(repositoryProvider).watchCourses(),
);
final smallGroupsStreamProvider = StreamProvider<List<SmallGroup>>(
  (ref) => ref.watch(repositoryProvider).watchSmallGroups(),
);
final settingsStreamProvider = StreamProvider<Map<String, String>>(
  (ref) => ref.watch(repositoryProvider).watchSettings(),
);

/// Saved settings as a plain map, empty while loading.
final settingsProvider = Provider<Map<String, String>>(
  (ref) => ref.watch(settingsStreamProvider).valueOrNull ?? const {},
);

/// Reads a stream provider's current value, or an empty list while it loads.
///
/// Screens stay synchronous this way: they were written against plain lists,
/// and the first frame simply shows an empty table rather than each screen
/// having to handle loading and error states individually.
List<T> _value<T>(Ref ref, ProviderListenable<AsyncValue<List<T>>> p) =>
    ref.watch(p).valueOrNull ?? const [];

/// The single seam between the UI and its data.
///
/// Every screen reads through these providers and never imports `lib/data`
/// directly. When the backend arrives, only the bodies below change — they
/// become async repository calls (`FutureProvider`) while the widgets that
/// consume them keep the same names and shapes.
///
/// **Everything here is branch-scoped.** Each list is filtered to
/// [activeBranchIdsProvider] before a screen ever sees it, so a Branch Pastor
/// cannot read another branch's data by opening a screen that forgot to
/// filter. Unscoped `*All` variants exist only where a cross-branch roll-up is
/// genuinely intended, and they are named so that is obvious at the call site.

/// Filters any branch-tagged list to the active scope.
List<T> _scoped<T>(Ref ref, List<T> all, String Function(T) branchOf) {
  final active = ref.watch(activeBranchIdsProvider);
  return all.where((item) => active.contains(branchOf(item))).toList();
}

/* ---------------------------------------------------------------- branches */

final branchesProvider =
    Provider<List<Branch>>((ref) => _value(ref, branchesStreamProvider));

final branchByIdProvider = Provider.family<Branch?, String>(
  (ref, id) => ref.watch(branchesProvider).where((b) => b.id == id).firstOrNull,
);

/// Display name for a branch id; "All branches" when null.
final branchNameProvider = Provider.family<String, String?>((ref, id) {
  if (id == null) return 'All branches';
  return ref.watch(branchByIdProvider(id))?.name ?? 'Unknown branch';
});

/// Short code for a branch id; "ALL" when null.
final branchCodeProvider = Provider.family<String, String?>((ref, id) {
  if (id == null) return 'ALL';
  return ref.watch(branchByIdProvider(id))?.code ?? '—';
});

/// Display name for a department instance, taken from its catalogue type.
final departmentNameProvider = Provider.family<String, String>((ref, id) {
  final department = ref.watch(departmentByIdProvider(id));
  if (department == null) return 'Unknown department';
  return ref.watch(departmentTypeByIdProvider(department.typeId))?.name ??
      'Department';
});

/* ------------------------------------------------------------------ people */

final membersProvider = Provider<List<Member>>(
  (ref) => _scoped(ref, ref.watch(membersAllProvider), (m) => m.branchId),
);

/// Every member regardless of scope — for cross-branch roll-ups only.
final membersAllProvider =
    Provider<List<Member>>((ref) => _value(ref, membersStreamProvider));

final memberByIdProvider = Provider.family<Member?, String>(
  (ref, id) =>
      ref.watch(membersAllProvider).where((m) => m.id == id).firstOrNull,
);

/// Resolves an id to a display name, tolerating null and unknown ids.
final memberNameProvider = Provider.family<String, String?>((ref, id) {
  if (id == null) return 'Unassigned';
  return ref.watch(memberByIdProvider(id))?.fullName ?? 'Unknown';
});

/// Families are derived from members rather than stored separately.
final familiesProvider = Provider<List<Family>>((ref) {
  final members = ref.watch(membersProvider);
  final byFamily = <String, List<Member>>{};
  for (final m in members) {
    if (m.familyId != null) byFamily.putIfAbsent(m.familyId!, () => []).add(m);
  }
  return [
    for (final entry in byFamily.entries)
      Family(
        id: entry.key,
        name: 'The ${entry.value.first.lastName} Family',
        headMemberId: entry.value.first.id,
        memberIds: entry.value.map((m) => m.id).toList(),
        branchId: entry.value.first.branchId,
        address: entry.value.first.address,
      ),
  ];
});

/* -------------------------------------------------------------- departments */

/// The shared catalogue of department types — church-wide by definition.
final departmentTypesProvider = Provider<List<DepartmentType>>(
  (ref) => _value(ref, departmentTypesStreamProvider),
);

final departmentTypeByIdProvider = Provider.family<DepartmentType?, String>(
  (ref, id) =>
      ref.watch(departmentTypesProvider).where((t) => t.id == id).firstOrNull,
);

final departmentsProvider = Provider<List<Department>>(
  (ref) => _scoped(ref, ref.watch(departmentsAllProvider), (d) => d.branchId),
);

final departmentsAllProvider = Provider<List<Department>>(
  (ref) => _value(ref, departmentsStreamProvider),
);

final departmentByIdProvider = Provider.family<Department?, String>(
  (ref, id) =>
      ref.watch(departmentsAllProvider).where((d) => d.id == id).firstOrNull,
);

/// The same department type across every visible branch — the cross-branch
/// roll-up the shared catalogue exists to enable.
final departmentsOfTypeProvider = Provider.family<List<Department>, String>(
  (ref, typeId) =>
      ref.watch(departmentsProvider).where((d) => d.typeId == typeId).toList(),
);

/// Members belonging to a department, resolved from ids.
final departmentMembersProvider = Provider.family<List<Member>, String>(
  (ref, departmentId) {
    final department = ref.watch(departmentByIdProvider(departmentId));
    if (department == null) return const [];
    final all = ref.watch(membersAllProvider);
    return [
      for (final id in department.memberIds)
        ...all.where((m) => m.id == id),
    ]..sort((a, b) => a.lastName.compareTo(b.lastName));
  },
);

/* -------------------------------------------------------------- structure */

final ministriesProvider = Provider<List<Ministry>>(
  (ref) => const <Ministry>[],
);
/// Every leadership post across branches, departments and groups.
///
/// Assembled from the places leadership is actually recorded, so it cannot drift
/// out of step with them: change a department's head and this list changes with
/// it. Scoped like everything else — a branch pastor sees their own branch's
/// leaders, not the whole church's.
final leadershipPostsProvider = Provider<List<LeadershipPost>>((ref) {
  final branches = ref.watch(branchesProvider);
  final departments = ref.watch(departmentsProvider);
  final groups = ref.watch(smallGroupsProvider);
  final posts = <LeadershipPost>[];

  for (final b in branches) {
    if (b.pastorId.isNotEmpty) {
      posts.add(LeadershipPost(
        memberId: b.pastorId,
        role: LeadershipRole.branchPastor,
        branchId: b.id,
        scopeName: b.name,
        scopeId: b.id,
      ));
    }
    final assistant = b.assistantPastorId ?? '';
    if (assistant.isNotEmpty) {
      posts.add(LeadershipPost(
        memberId: assistant,
        role: LeadershipRole.assistantPastor,
        branchId: b.id,
        scopeName: b.name,
        scopeId: b.id,
      ));
    }
  }

  for (final d in departments) {
    final name = ref.watch(departmentNameProvider(d.id));
    if (d.headId.isNotEmpty) {
      posts.add(LeadershipPost(
        memberId: d.headId,
        role: LeadershipRole.departmentHead,
        branchId: d.branchId,
        scopeName: name,
        scopeId: d.id,
      ));
    }
    final assistant = d.assistantHeadId ?? '';
    if (assistant.isNotEmpty) {
      posts.add(LeadershipPost(
        memberId: assistant,
        role: LeadershipRole.assistantDepartmentHead,
        branchId: d.branchId,
        scopeName: name,
        scopeId: d.id,
      ));
    }
  }

  for (final g in groups) {
    if (g.leaderId.isNotEmpty) {
      posts.add(LeadershipPost(
        memberId: g.leaderId,
        role: LeadershipRole.groupLeader,
        branchId: g.branchId,
        scopeName: g.name,
        scopeId: g.id,
      ));
    }
  }

  posts.sort((a, b) {
    final byRole = a.role.index.compareTo(b.role.index);
    return byRole != 0 ? byRole : a.scopeName.compareTo(b.scopeName);
  });
  return posts;
});

/// Everyone carrying a pastoral title, whether or not they lead anything.
///
/// A branch can have a branch pastor plus several associate or youth pastors,
/// and only the first of those holds a post. Titles are the answer: the branch
/// leadership columns say who *leads*, and this says who *is a pastor*.
final pastorsProvider = Provider<List<Member>>((ref) {
  final pastors =
      ref.watch(membersProvider).where((m) => m.isPastor).toList();
  pastors.sort((a, b) => a.lastName.compareTo(b.lastName));
  return pastors;
});

/// The Pastors & leaders list: everyone with a pastoral title or a post.
///
/// Both kinds belong here, and they overlap. A branch pastor usually has both a
/// title and a post; an associate pastor has a title and no post; a department
/// head may have a post and no title. Keying by member means each person is one
/// row regardless of which applies, so nobody is listed twice and nobody with a
/// title is left out just because they lead nothing.
final leadersProvider = Provider<List<({Member member, List<LeadershipPost> posts})>>(
  (ref) {
    final byMember = <String, List<LeadershipPost>>{};
    for (final post in ref.watch(leadershipPostsProvider)) {
      byMember.putIfAbsent(post.memberId, () => []).add(post);
    }

    final members = ref.watch(membersProvider);
    // Titled pastors with no post still get a row, with an empty post list.
    for (final pastor in ref.watch(pastorsProvider)) {
      byMember.putIfAbsent(pastor.id, () => []);
    }

    final rows = <({Member member, List<LeadershipPost> posts})>[];
    for (final entry in byMember.entries) {
      final member = members.where((m) => m.id == entry.key).firstOrNull;
      // A post naming someone outside the current scope is skipped rather than
      // rendered as a blank row.
      if (member != null) rows.add((member: member, posts: entry.value));
    }

    rows.sort((a, b) {
      // Post-holders first, most senior post leading; then titled pastors.
      final rankA = a.posts.isEmpty ? 99 : a.posts.first.role.index;
      final rankB = b.posts.isEmpty ? 99 : b.posts.first.role.index;
      return rankA != rankB
          ? rankA.compareTo(rankB)
          : a.member.lastName.compareTo(b.member.lastName);
    });
    return rows;
  },
);

final smallGroupsProvider = Provider<List<SmallGroup>>(
  (ref) => _scoped(ref, _value(ref, smallGroupsStreamProvider), (g) => g.branchId),
);
final coursesProvider = Provider<List<Course>>(
  (ref) => _scoped(ref, _value(ref, coursesStreamProvider), (c) => c.branchId),
);
final volunteerSlotsProvider = Provider<List<VolunteerSlot>>(
  (ref) => _scoped(ref, _value(ref, slotsStreamProvider), (s) => s.branchId),
);

/* --------------------------------------------------------------- activity */

final eventsProvider = Provider<List<ChurchEvent>>(
  (ref) => _scoped(ref, _value(ref, eventsStreamProvider), (e) => e.branchId),
);

final upcomingEventsProvider = Provider<List<ChurchEvent>>((ref) {
  final today = DateTime.now().toUtc().subtract(const Duration(days: 1));
  return ref.watch(eventsProvider)
      .where((e) => e.startsAt.isAfter(today))
      .toList()
    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
});

final attendanceRecordsProvider = Provider<List<AttendanceRecord>>(
  (ref) => _scoped(ref, _value(ref, attendanceStreamProvider), (r) => r.branchId),
);

/// Attendance trend for the active scope, summed per service date.
final attendanceTrendProvider = Provider<List<TrendPoint>>(
  (ref) => ev.attendanceTrendFor(ref.watch(attendanceRecordsProvider)),
);

final announcementsProvider = Provider<List<AnnouncementItem>>(
  (ref) => _scoped(ref, _value(ref, announcementsStreamProvider), (a) => a.branchId),
);

/// Every service one member was present at.
final memberAttendanceProvider =
    StreamProvider.family<List<MemberAttendance>, String>(
  (ref, memberId) =>
      ref.watch(repositoryProvider).watchMemberAttendance(memberId),
);

/// Everyone individually checked in at one service.
final serviceAttendeesProvider =
    StreamProvider.family<List<Member>, String>(
  (ref, attendanceId) =>
      ref.watch(repositoryProvider).watchServiceAttendees(attendanceId),
);

/// A member's attendance across the last few services at their branch.
final memberAttendanceRateProvider =
    FutureProvider.family<({int attended, int total}), Member>(
  (ref, member) => ref
      .watch(repositoryProvider)
      .attendanceRate(member.id, branchId: member.branchId),
);

/* ------------------------------------------------------------------ money */

final donationsProvider = Provider<List<Donation>>(
  (ref) => _scoped(ref, _value(ref, donationsStreamProvider), (d) => d.branchId),
);
final pledgesProvider =
    Provider<List<Pledge>>((ref) => _value(ref, pledgesStreamProvider));
final expensesProvider = Provider<List<ExpenseRecord>>(
  (ref) => _scoped(ref, _value(ref, expensesStreamProvider), (e) => e.branchId),
);

final financeTrendProvider = Provider<List<TrendPoint>>(
  (ref) => fin.financeTrendOf(
    ref.watch(donationsProvider),
    expenses: ref.watch(expensesProvider),
  ),
);
final givingByFundProvider = Provider<List<CategoryPoint>>(
  (ref) => fin.givingByFundOf(ref.watch(donationsProvider)),
);
final totalGivingProvider = Provider<double>(
  (ref) => fin.totalGivingOf(ref.watch(donationsProvider)),
);
final totalExpensesProvider = Provider<double>(
  (ref) => fin.totalExpensesOf(ref.watch(expensesProvider)),
);

/* ------------------------------------------------------------- operations */

final campaignsProvider = Provider<List<Campaign>>(
  (ref) => _scoped(ref, _value(ref, campaignsStreamProvider), (c) => c.branchId),
);
final careRequestsProvider = Provider<List<CareRequest>>(
  (ref) => _scoped(ref, _value(ref, careStreamProvider), (c) => c.branchId),
);
final assetsProvider = Provider<List<AssetItem>>(
  (ref) => _scoped(ref, _value(ref, assetsStreamProvider), (a) => a.branchId),
);

/// Staff accounts the current user may see: church-wide roles always, plus
/// anyone attached to a branch in scope.
final staffUsersProvider = Provider<List<StaffUser>>((ref) {
  final active = ref.watch(activeBranchIdsProvider);
  final multiBranch = ref.watch(currentUserProvider).canSeeAllBranches;
  return ref.watch(usersStreamProvider).valueOrNull?.where((u) {
    if (u.branchId == null) return multiBranch;
    return active.contains(u.branchId);
  }).toList() ?? const [];
});

/// The effective permission matrix — built-in defaults plus any saved edits.
final permissionMatrixStreamProvider =
    StreamProvider<List<ModulePermission>>(
  (ref) => ref.watch(repositoryProvider).watchPermissionMatrix(),
);

final permissionMatrixProvider = Provider<List<ModulePermission>>((ref) =>
    ref.watch(permissionMatrixStreamProvider).valueOrNull ??
    ops.permissionMatrix);

/* -------------------------------------------------------------- dashboard */

final kpiStatsProvider = Provider<List<KpiStat>>(
  (ref) => dash.kpiStatsFor(
    members: ref.watch(membersProvider),
    attendance: ref.watch(attendanceRecordsProvider),
    donations: ref.watch(donationsProvider),
    groups: ref.watch(smallGroupsProvider),
    departments: ref.watch(departmentsProvider),
  ),
);

final recentActivityProvider =
    Provider<List<ActivityEntry>>((ref) => dash.recentActivity);

final ageDistributionProvider = Provider<List<CategoryPoint>>(
  (ref) => dash.ageDistributionOf(ref.watch(membersProvider)),
);
final genderSplitProvider = Provider<List<CategoryPoint>>(
  (ref) => dash.genderSplitOf(ref.watch(membersProvider)),
);
final growthFunnelProvider = Provider<List<CategoryPoint>>(
  (ref) => dash.growthFunnelOf(ref.watch(membersProvider)),
);

/// Attendance per branch — only meaningful in a consolidated view.
final attendanceByBranchProvider = Provider<List<CategoryPoint>>((ref) {
  final active = ref.watch(activeBranchIdsProvider);
  final records = ref.watch(attendanceRecordsProvider);

  return [
    for (final branch in ref.watch(branchesProvider).where((b) => active.contains(b.id)))
      CategoryPoint(
        label: branch.code,
        value: records
            .where((r) => r.branchId == branch.id)
            .take(2)
            .fold(0.0, (sum, r) => sum + r.total),
      ),
  ]..sort((a, b) => b.value.compareTo(a.value));
});

/// Members per branch, for the branch comparison chart.
final membersByBranchProvider = Provider<List<CategoryPoint>>((ref) {
  final active = ref.watch(activeBranchIdsProvider);
  final all = ref.watch(membersProvider);

  return [
    for (final branch in ref.watch(branchesProvider).where((b) => active.contains(b.id)))
      CategoryPoint(
        label: branch.code,
        value: all.where((m) => m.branchId == branch.id).length.toDouble(),
      ),
  ]..sort((a, b) => b.value.compareTo(a.value));
});

/// Giving per branch, for the branch comparison chart.
final givingByBranchProvider = Provider<List<CategoryPoint>>((ref) {
  final active = ref.watch(activeBranchIdsProvider);
  final scoped = ref.watch(donationsProvider);

  return [
    for (final branch in ref.watch(branchesProvider).where((b) => active.contains(b.id)))
      CategoryPoint(
        label: branch.code,
        value: scoped
            .where((d) => d.branchId == branch.id)
            .fold(0.0, (sum, d) => sum + d.amount),
      ),
  ]..sort((a, b) => b.value.compareTo(a.value));
});

/* ------------------------------------------------------------------ prefs */

/// Whether the user has collapsed the sidebar to icons.
///
/// Separate from the width-driven behaviour: below the medium breakpoint the
/// sidebar collapses regardless, but above it this lets someone reclaim the
/// width on a smaller laptop screen even when there is technically room.
final sidebarCollapsedProvider =
    NotifierProvider<SidebarCollapsedNotifier, bool>(
        SidebarCollapsedNotifier.new);

class SidebarCollapsedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

/// App-wide light/dark/system preference. In-memory for now; persist with
/// shared_preferences when settings are made durable.
final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void set(ThemeMode mode) => state = mode;

  void toggle() =>
      state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}
