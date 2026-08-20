import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'db/database.dart';
import 'providers/auth.dart';
import 'providers/permissions.dart';
import 'screens/sign_in_screen.dart';

import 'config/app_config.dart';
import 'config/features.dart';
import 'providers/repository.dart';
import 'screens/access_screen.dart';
import 'screens/assets_screen.dart';
import 'screens/branches_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/care_screen.dart';
import 'screens/communication_screen.dart';
import 'screens/departments_screen.dart';
import 'screens/discipleship_screen.dart';
import 'screens/events_screen.dart';
import 'screens/finance_screen.dart';
import 'screens/member_detail_screen.dart';
import 'screens/members_screen.dart';
import 'screens/ministries_screen.dart';
import 'screens/overview_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/volunteers_screen.dart';
import 'shell/app_shell.dart';
import 'theme/app_theme.dart';
import 'utils/formatters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // `intl` needs locale data loaded before any DateFormat runs; without this
  // every formatted date throws LocaleDataException on first paint.
  await initializeDateFormatting(Fmt.locale);

  // Opening the database also seeds it on first run, so the app is never
  // started against half-built storage.
  //
  // Guarded and time-boxed: if storage cannot be opened the app must still
  // start and say so, rather than hanging on a blank screen with no
  // explanation — which is exactly what an unguarded await produced on web.
  final database = AppDatabase();
  String? startupError;

  try {
    await database.isEmpty.timeout(const Duration(seconds: 20));
  } on TimeoutException {
    startupError = 'The database took too long to open.';
  } catch (error) {
    startupError = '$error';
  }

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: startupError == null
          ? const ChurchApp()
          : _StartupFailure(message: startupError),
    ),
  );
}

/// Route table. Every screen sits inside [AppShell] via a ShellRoute, so the
/// sidebar and top bar persist across navigation instead of rebuilding.
GoRouter _buildRouter(Ref ref) => GoRouter(
  initialLocation: '/dashboard',
  // Rebuilds the redirect whenever the session changes, so signing in or out
  // moves the user immediately without any screen having to navigate manually.
  refreshListenable: _SessionListenable(ref),
  redirect: (context, state) {
    final signedIn = ref.read(sessionProvider) != null;
    final atSignIn = state.matchedLocation == '/sign-in';

    if (!signedIn) return atSignIn ? null : '/sign-in';
    if (atSignIn) return '/dashboard';

    // Typing the URL must not bypass the sidebar's own filtering.
    if (state.matchedLocation == '/branches' &&
        !ref.read(canSeeAllBranchesProvider)) {
      return '/dashboard';
    }

    // Switched-off modules are unreachable, not merely unlisted.
    if (Features.hiddenRoutes.contains(state.matchedLocation)) {
      return '/dashboard';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/sign-in',
      pageBuilder: (c, s) => const NoTransitionPage(child: SignInScreen()),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: OverviewScreen()),
        ),
        // Reports moved into a tab on the dashboard. The route stays so old
        // links, bookmarks and the Export button still land in the right place.
        GoRoute(
          path: '/reports',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: OverviewScreen(initialTab: 1)),
        ),
        GoRoute(
          path: '/branches',
          pageBuilder: (c, s) => const NoTransitionPage(child: BranchesScreen()),
        ),
        GoRoute(
          path: '/departments',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: DepartmentsScreen()),
        ),
        GoRoute(
          path: '/members',
          pageBuilder: (c, s) => const NoTransitionPage(child: MembersScreen()),
          routes: [
            GoRoute(
              path: ':memberId',
              pageBuilder: (c, s) => NoTransitionPage(
                child: MemberDetailScreen(
                  memberId: s.pathParameters['memberId']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/attendance',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: AttendanceScreen()),
        ),
        GoRoute(
          path: '/ministries',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: MinistriesScreen()),
        ),
        GoRoute(
          path: '/care',
          pageBuilder: (c, s) => const NoTransitionPage(child: CareScreen()),
        ),
        GoRoute(
          path: '/discipleship',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: DiscipleshipScreen()),
        ),
        GoRoute(
          path: '/events',
          pageBuilder: (c, s) => const NoTransitionPage(child: EventsScreen()),
        ),
        GoRoute(
          path: '/volunteers',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: VolunteersScreen()),
        ),
        GoRoute(
          path: '/finance',
          pageBuilder: (c, s) => const NoTransitionPage(child: FinanceScreen()),
        ),
        GoRoute(
          path: '/communication',
          pageBuilder: (c, s) =>
              const NoTransitionPage(child: CommunicationScreen()),
        ),
        GoRoute(
          path: '/assets',
          pageBuilder: (c, s) => const NoTransitionPage(child: AssetsScreen()),
        ),
        GoRoute(
          path: '/access',
          pageBuilder: (c, s) => const NoTransitionPage(child: AccessScreen()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (c, s) => const NoTransitionPage(child: SettingsScreen()),
        ),
      ],
    ),
  ],
);

/// Bridges Riverpod's session state to go_router's refresh mechanism.
class _SessionListenable extends ChangeNotifier {
  _SessionListenable(Ref ref) {
    ref.listen(sessionProvider, (_, _) => notifyListeners());
  }
}

/// Built once and kept for the app's lifetime; rebuilding it would reset
/// navigation on every session change.
final routerProvider = Provider<GoRouter>(_buildRouter);

class ChurchApp extends ConsumerWidget {
  const ChurchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: '${ChurchConfig.name} · ${AppInfo.shortName}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(themeModeProvider),
      routerConfig: ref.watch(routerProvider),
    );
  }
}

/// Shown when the database cannot be opened.
///
/// Storage is the whole app, so a failure here is fatal — but it should be a
/// legible message, not a blank window.
class _StartupFailure extends StatelessWidget {
  const _StartupFailure({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.storage_outlined, size: 40),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'The app could not open its database',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
