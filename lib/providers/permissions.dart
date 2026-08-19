import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../config/permissions.dart' show permissionMatrix;
import '../models/models.dart';
import 'auth.dart';
import 'repository.dart';

/// Access control for the whole app.
///
/// Two dimensions, always applied together:
///
///   * **What** you may do — [ModulePermission] × [UserRole] → [PermissionLevel]
///   * **Whose data** you see — [UserRole.scope] → which branches are visible
///
/// A Branch Pastor has `full` on Members, but only for their own branch. A HQ
/// Finance user has `full` on Giving across every branch. Neither statement
/// makes sense without the other half.
///
/// **This is a UI convenience, not a security boundary.** When the backend
/// lands, every one of these checks must be repeated server-side; a hidden
/// button stops nobody who can call the API directly.

/// The signed-in user.
///
/// Reads straight from the authenticated session. Before sign-in nothing is
/// rendered behind the router guard, so the fallback below is only ever a
/// placeholder for the brief frame during sign-out.
final currentUserProvider = Provider<StaffUser>((ref) {
  return ref.watch(sessionProvider) ??
      StaffUser(
        id: 'anonymous',
        name: 'Signed out',
        username: '',
        role: UserRole.member,
        lastActiveAt: DateTime.now().toUtc(),
        status: AccountStatus.suspended,
      );
});

/// Branch ids the current user is allowed to see, in display order.
final visibleBranchIdsProvider = Provider<List<String>>((ref) {
  final user = ref.watch(currentUserProvider);
  final all = ref.watch(branchesProvider).map((b) => b.id).toList();

  if (user.canSeeAllBranches) return all;
  if (user.branchId != null) return [user.branchId!];
  return const [];
});

/// The branches themselves, for the switcher and any branch picker.
final visibleBranchesProvider = Provider<List<Branch>>((ref) {
  final ids = ref.watch(visibleBranchIdsProvider).toSet();
  return ref.watch(branchesProvider).where((b) => ids.contains(b.id)).toList();
});

/// Whether the current user may switch between branches at all.
final canSwitchBranchProvider = Provider<bool>(
  (ref) => ref.watch(visibleBranchIdsProvider).length > 1,
);

/// Whether the current user may see any branch other than their own.
///
/// This is the single gate for every cross-branch affordance: the Branches
/// screen, the branch switcher, branch columns in tables, and any total that
/// spans campuses. Without it the app behaves as though the user's branch is
/// the whole church.
final canSeeAllBranchesProvider = Provider<bool>(
  (ref) => ref.watch(currentUserProvider).canSeeAllBranches,
);

/// The branch currently being viewed. `null` means "All branches", which is
/// only reachable by a multi-branch role.
final selectedBranchProvider =
    NotifierProvider<SelectedBranchNotifier, String?>(
        SelectedBranchNotifier.new);

class SelectedBranchNotifier extends Notifier<String?> {
  @override
  String? build() {
    final user = ref.watch(currentUserProvider);
    // Multi-branch roles land on the consolidated view; everyone else is
    // pinned to their own branch and never sees the switcher.
    return user.canSeeAllBranches ? null : user.branchId;
  }

  void select(String? branchId) {
    final allowed = ref.read(visibleBranchIdsProvider);
    if (branchId != null && !allowed.contains(branchId)) return;
    if (branchId == null && !ref.read(currentUserProvider).canSeeAllBranches) {
      return;
    }
    state = branchId;
  }
}

/// The branch ids that data should actually be filtered to right now — one
/// branch when a specific one is selected, otherwise everything visible.
///
/// Every scoped provider funnels through this, so branch filtering is defined
/// in exactly one place.
final activeBranchIdsProvider = Provider<Set<String>>((ref) {
  final selected = ref.watch(selectedBranchProvider);
  final visible = ref.watch(visibleBranchIdsProvider);
  return selected == null ? visible.toSet() : {selected};
});

/// True when the view spans more than one branch — used to show or hide the
/// "Branch" column in tables.
final isConsolidatedViewProvider = Provider<bool>(
  (ref) => ref.watch(activeBranchIdsProvider).length > 1,
);

/* ----------------------------------------------------------- capability */

final _matrixByModule = {
  for (final entry in permissionMatrix) entry.module: entry,
};

/// The current user's permission level for a named module.
final permissionForProvider = Provider.family<PermissionLevel, String>(
  (ref, module) {
    final role = ref.watch(currentUserProvider).role;
    return _matrixByModule[module]?.levelFor(role) ?? PermissionLevel.none;
  },
);

/// Convenience: may the current user open this module at all?
final canViewProvider = Provider.family<bool, String>(
  (ref, module) => ref.watch(permissionForProvider(module)).canRead,
);

/// Convenience: may the current user create/edit/delete in this module?
final canEditProvider = Provider.family<bool, String>(
  (ref, module) => ref.watch(permissionForProvider(module)).canWrite,
);

/// The department a department-head or volunteer is tied to, if any.
final ownDepartmentProvider = Provider<Department?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user.departmentId == null) return null;
  return ref.watch(departmentByIdProvider(user.departmentId!));
});

/// A short human sentence describing the current user's reach, shown in the
/// UI so it is never a mystery why something is hidden.
final scopeDescriptionProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  final branchName = ref.watch(branchNameProvider(user.branchId));

  return switch (user.effectiveScope) {
    RoleScope.allBranches =>
      'All ${ref.watch(branchesProvider).length} branches',
    RoleScope.ownBranch => branchName,
    RoleScope.ownDepartment => () {
        final dept = ref.watch(ownDepartmentProvider);
        if (dept == null) return branchName;
        final type = ref.watch(departmentTypeByIdProvider(dept.typeId));
        final code = ref.watch(branchByIdProvider(dept.branchId))?.code ?? '';
        return '${type?.name ?? 'Department'} · $code';
      }(),
    RoleScope.self => 'Personal profile only',
  };
});
