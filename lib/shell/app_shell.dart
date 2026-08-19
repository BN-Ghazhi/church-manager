import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../config/app_config.dart';
import '../config/navigation.dart';
import '../config/permissions.dart' show permissionMatrix;
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../widgets/collapsible.dart';
import 'branch_switcher.dart';
import 'command_palette.dart';
import 'user_switcher.dart';

/// The persistent frame around every screen.
///
/// Adapts to the window rather than the platform, so the same build works as a
/// desktop app and in a browser:
///   * expanded  — full sidebar with section labels
///   * medium    — icon rail
///   * compact   — hamburger + drawer
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final location = GoRouterState.of(context).uri.path;
    final current = findNavItem(location);

    final isCompact = AppBreakpoints.isCompact(width);

    // The sidebar shows labels when there is room *and* the user has not
    // collapsed it. Below the medium breakpoint there is no room either way.
    final isExpanded = AppBreakpoints.isExpanded(width) &&
        !ref.watch(sidebarCollapsedProvider);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): () =>
            showCommandPalette(context),
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true): () =>
            showCommandPalette(context),
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          drawer: isCompact
              ? Drawer(
                  child: _SidebarContent(
                    location: location,
                    onNavigate: (route) {
                      Navigator.of(context).pop();
                      context.go(route);
                    },
                  ),
                )
              : null,
          body: Row(
            children: [
              if (!isCompact)
                _Sidebar(
                  expanded: isExpanded,
                  location: location,
                  onNavigate: context.go,
                ),
              Expanded(
                child: Column(
                  children: [
                    _TopBar(title: current?.title ?? 'Overview', location: location),
                    Expanded(child: child),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.expanded,
    required this.location,
    required this.onNavigate,
  });

  final bool expanded;
  final String location;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: expanded ? 262 : 72,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          right: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.7)),
        ),
      ),
      child: _SidebarContent(
        location: location,
        onNavigate: onNavigate,
        collapsed: !expanded,
      ),
    );
  }
}

class _SidebarContent extends ConsumerWidget {
  const _SidebarContent({
    required this.location,
    required this.onNavigate,
    this.collapsed = false,
  });

  final String location;
  final ValueChanged<String> onNavigate;
  final bool collapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Destinations the signed-in role cannot read are hidden entirely, so the
    // sidebar never lists a dead end.
    final role = ref.watch(currentUserProvider).role;
    final canSeeAllBranches = ref.watch(canSeeAllBranchesProvider);

    final visibleSections = [
      for (final section in navigation)
        (
          label: section.label,
          items: section.items.where((i) {
            // The Branches screen is about other campuses by definition, so it
            // is gated on cross-branch sight rather than on a module level.
            if (i.route == '/branches' && !canSeeAllBranches) return false;
            return permissionMatrix
                .where((m) => m.module == i.module)
                .every((m) => m.levelFor(role).canRead);
          }).toList(),
        ),
    ].where((s) => s.items.isNotEmpty).toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(Icons.church, size: 18, color: scheme.onPrimary),
                ),
                if (!collapsed) ...[
                  const SizedBox(width: AppSpacing.sm + 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Wraps to a second line rather than clipping: a church
                        // name is not something to truncate, and "Kingdom Grace
                        // Chapel" does not fit the sidebar on one line.
                        Text(
                          ChurchConfig.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          ChurchConfig.tagline,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 1),

          // Destinations
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              children: [
                for (final section in visibleSections) ...[
                  if (!collapsed)
                    // Sections fold away so a sidebar of sixteen destinations
                    // does not have to be read top to bottom every time. The
                    // section holding the current page always stays open.
                    _SectionHeader(
                      label: section.label,
                      collapsedKey: 'nav.${section.label}',
                      containsCurrent: section.items.any((i) =>
                          location == i.route ||
                          location.startsWith('${i.route}/')),
                    )
                  else
                    const SizedBox(height: AppSpacing.sm),
                  if (collapsed ||
                      !ref.watch(collapsedSectionsProvider)
                          .contains('nav.${section.label}') ||
                      section.items.any((i) =>
                          location == i.route ||
                          location.startsWith('${i.route}/')))
                    for (final item in section.items)
                      _NavTile(
                        item: item,
                        selected: location == item.route ||
                            location.startsWith('${item.route}/'),
                        collapsed: collapsed,
                        onTap: () => onNavigate(item.route),
                      ),
                ],
              ],
            ),
          ),

          const Divider(height: 1),
          UserSwitcher(collapsed: collapsed),
        ],
      ),
    );
  }
}

/// A foldable sidebar group heading.
class _SectionHeader extends ConsumerWidget {
  const _SectionHeader({
    required this.label,
    required this.collapsedKey,
    required this.containsCurrent,
  });

  final String label;
  final String collapsedKey;

  /// The section holding the page you are on cannot be folded away — hiding the
  /// highlighted item would leave no indication of where you are.
  final bool containsCurrent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final folded =
        !containsCurrent && ref.watch(collapsedSectionsProvider).contains(collapsedKey);

    return InkWell(
      onTap: containsCurrent
          ? null
          : () => ref
              .read(collapsedSectionsProvider.notifier)
              .toggle(collapsedKey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xs,
        ),
        child: Row(
          children: [
            Icon(
              folded ? Icons.chevron_right : Icons.expand_more,
              size: 14,
              color: scheme.onSurfaceVariant
                  .withValues(alpha: containsCurrent ? 0.35 : 0.8),
            ),
            const SizedBox(width: 2),
            Text(
              label.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.collapsed,
    required this.onTap,
  });

  final NavItem item;
  final bool selected;
  final bool collapsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = selected ? scheme.onSurface : scheme.onSurfaceVariant;

    final tile = Container(
      margin: EdgeInsets.symmetric(
        horizontal: collapsed ? AppSpacing.sm + 2 : AppSpacing.sm + 4,
        vertical: 1,
      ),
      child: Material(
        color: selected
            ? scheme.surfaceContainerHighest.withValues(alpha: 0.8)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: collapsed ? 0 : AppSpacing.sm + 2,
              vertical: AppSpacing.sm + 2,
            ),
            child: Row(
              mainAxisAlignment: collapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  selected ? item.selectedIcon : item.icon,
                  size: 19,
                  color: color,
                ),
                if (!collapsed) ...[
                  const SizedBox(width: AppSpacing.sm + 4),
                  Expanded(
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                  if (item.badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        item.badge!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    return collapsed ? Tooltip(message: item.title, child: tile) : tile;
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar({required this.title, required this.location});

  final String title;
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = AppBreakpoints.isCompact(width);
    final collapsed = ref.watch(sidebarCollapsedProvider);
    final section = findNavItem(location) != null
        ? sectionOf(findNavItem(location)!.route)
        : null;
    final mode = ref.watch(themeModeProvider);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.7)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          if (isCompact)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'Open navigation',
              ),
            )
          else
            // Lets the sidebar be collapsed to icons even when the window is
            // wide enough for labels, for anyone who wants the screen space.
            IconButton(
              icon: Icon(
                collapsed
                    ? Icons.keyboard_double_arrow_right
                    : Icons.keyboard_double_arrow_left,
              ),
              tooltip: collapsed ? 'Expand sidebar' : 'Collapse sidebar',
              onPressed: () =>
                  ref.read(sidebarCollapsedProvider.notifier).toggle(),
            ),
          // Breadcrumb
          Expanded(
            child: Row(
              children: [
                if (!isCompact && section != null) ...[
                  Text(
                    section,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    child: Icon(Icons.chevron_right,
                        size: 15, color: scheme.onSurfaceVariant),
                  ),
                ],
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          BranchSwitcher(compact: isCompact),
          const SizedBox(width: AppSpacing.sm),
          // Search
          if (!isCompact)
            _SearchButton(onTap: () => showCommandPalette(context))
          else
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () => showCommandPalette(context),
            ),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            icon: Badge(
              smallSize: 7,
              backgroundColor: AppTheme.danger,
              child: const Icon(Icons.notifications_outlined),
            ),
            tooltip: 'Notifications',
            onPressed: () => _showNotifications(context),
          ),
          IconButton(
            icon: Icon(
              mode == ThemeMode.dark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            tooltip: 'Toggle theme',
            onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Notification('6 care requests are unassigned', '2 hours ago'),
              _Notification('Sunday rota has 3 open slots', 'yesterday'),
              _Notification('Giving is 3.4% below last month', '2 days ago'),
              _Notification('2 assets flagged for repair', '3 days ago'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _Notification extends StatelessWidget {
  const _Notification(this.title, this.when);

  final String title;
  final String when;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            when,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: 210,
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 4),
        decoration: BoxDecoration(
          border: Border.all(color: scheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Search…',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Ctrl K',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
