import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import 'package:go_router/go_router.dart';

import '../providers/auth.dart';
import '../widgets/access_forms.dart';
import '../providers/permissions.dart';
import '../theme/app_theme.dart';

/// The signed-in identity, in the sidebar footer, with sign-out.
class UserSwitcher extends ConsumerWidget {
  const UserSwitcher({super.key, this.collapsed = false});

  final bool collapsed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final user = ref.watch(currentUserProvider);
    final scope = ref.watch(scopeDescriptionProvider);

    final avatar = CircleAvatar(
      radius: 16,
      backgroundColor: user.canSeeAllBranches
          ? AppTheme.warning.withValues(alpha: 0.18)
          : scheme.surfaceContainerHighest,
      child: Text(
        user.initials,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: user.canSeeAllBranches
              ? AppTheme.warning
              : scheme.onSurfaceVariant,
        ),
      ),
    );

    return PopupMenuButton<String>(
      tooltip: 'Account',
      position: PopupMenuPosition.over,
      onSelected: (value) {
        switch (value) {
          case 'password':
            showOwnPasswordForm(context);
          case 'signout':
            ref.read(sessionProvider.notifier).signOut();
            GoRouter.of(context).go('/sign-in');
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.name, style: theme.textTheme.bodySmall),
              Text(
                user.username,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        // Every account needs this: the first-run password is published in the
        // repository, so the admin has to be able to change their own.
        const PopupMenuItem<String>(
          value: 'password',
          child: Row(
            children: [
              Icon(Icons.key_outlined, size: 17),
              SizedBox(width: AppSpacing.sm + 2),
              Text('Change password'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'signout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 17),
              SizedBox(width: AppSpacing.sm + 2),
              Text('Sign out'),
            ],
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm + 4),
        child: Row(
          children: [
            avatar,
            if (!collapsed) ...[
              const SizedBox(width: AppSpacing.sm + 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      user.role.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    Text(
                      scope,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: user.canSeeAllBranches
                            ? AppTheme.warning
                            : scheme.onSurfaceVariant.withValues(alpha: 0.75),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.unfold_more, size: 15, color: scheme.onSurfaceVariant),
            ],
          ],
        ),
      ),
    );
  }
}
