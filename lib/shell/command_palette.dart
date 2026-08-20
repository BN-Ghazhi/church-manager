import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';

import '../config/navigation.dart';
import '../providers/permissions.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';

/// Ctrl/Cmd+K palette over every screen and the member directory.
Future<void> showCommandPalette(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    builder: (_) => const _CommandPalette(),
  );
}

class _CommandPalette extends ConsumerStatefulWidget {
  const _CommandPalette();

  @override
  ConsumerState<_CommandPalette> createState() => _CommandPaletteState();
}

class _Result {
  const _Result(this.title, this.subtitle, this.route, this.icon, this.group);

  final String title;
  final String subtitle;
  final String route;
  final IconData icon;
  final String group;
}

class _CommandPaletteState extends ConsumerState<_CommandPalette> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    // Autofocus so the palette is usable from the keyboard alone.
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<_Result> get _results {
    final needle = _query.trim().toLowerCase();

    final canSeeAllBranches = ref.watch(canSeeAllBranchesProvider);

    final pages = [
      for (final section in navigation)
        for (final item in section.items)
          // Same two gates the sidebar applies. Without the permission check the
          // palette was a way to reach a page the sidebar deliberately hides.
          if (!(item.route == '/branches' && !canSeeAllBranches) &&
              ref.watch(canViewProvider(item.module)))
            _Result(item.title, item.description, item.route, item.icon,
                section.label),
    ];

    // Members surface only once the user types — otherwise hundreds of names
    // would bury the navigation — and only those they are allowed to see.
    final people = needle.isEmpty
        ? <_Result>[]
        : [
            for (final m in ref.watch(membersProvider))
              _Result(m.fullName, m.email, '/members/${m.id}',
                  Icons.person_outline, 'Members'),
          ];

    bool matches(_Result r) =>
        needle.isEmpty ||
        r.title.toLowerCase().contains(needle) ||
        r.subtitle.toLowerCase().contains(needle);

    return [
      ...pages.where(matches),
      ...people.where(matches).take(6),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final results = _results;

    // Group headers are inserted as the list is built.
    String? lastGroup;

    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(top: 96, left: 16, right: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 460),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm + 4),
              child: TextField(
                controller: _controller,
                focusNode: _focus,
                onChanged: (v) => setState(() => _query = v),
                onSubmitted: (_) {
                  if (results.isNotEmpty) _go(results.first.route);
                },
                decoration: const InputDecoration(
                  hintText: 'Search pages and members…',
                  prefixIcon: Icon(Icons.search, size: 18),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: results.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text(
                        'No results found.',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.sm),
                      itemCount: results.length,
                      itemBuilder: (context, i) {
                        final result = results[i];
                        final showHeader = result.group != lastGroup;
                        lastGroup = result.group;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showHeader)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    AppSpacing.md, AppSpacing.sm, 0, 2),
                                child: Text(
                                  result.group.toUpperCase(),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: scheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ListTile(
                              dense: true,
                              leading: Icon(result.icon, size: 18),
                              title: Text(
                                result.title,
                                style: theme.textTheme.bodyMedium,
                              ),
                              subtitle: Text(
                                result.subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              onTap: () => _go(result.route),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _go(String route) {
    Navigator.of(context).pop();
    GoRouter.of(context).go(route);
  }
}
