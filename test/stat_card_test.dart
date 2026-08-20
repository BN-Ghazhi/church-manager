import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/widgets/stat_card.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// A clickable card must only be clickable when its destination is open.
///
/// The risk with making cards navigate is a tile that looks pressable and then
/// bounces off a redirect, which reads as a broken app. These tests pin the
/// three states: reachable, switched off, and no destination at all.
void main() {
  late AppDatabase db;
  late StaffUser admin;

  setUpAll(Password.useFastHashingForTests);

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await Seeder(db).seedFirstRun();
    admin = (await ChurchRepository(db).signIn(
        Seeder.firstAdminUsername, Seeder.firstAdminPassword))!;
  });

  tearDown(() => db.close());

  /// Pumps one card inside a router, and reports where a tap landed.
  Future<String?> tapCard(WidgetTester tester, Widget card) async {
    String? landed;

    final container =
        ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(container.dispose);
    container.read(sessionProvider.notifier).refresh(admin);

    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, _) => Scaffold(body: card)),
        for (final route in ['/members', '/finance', '/attendance'])
          GoRoute(
            path: route,
            builder: (_, _) {
              landed = route;
              return const Scaffold(body: Text('arrived'));
            },
          ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        routerConfig: router,
      ),
    ));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    await tester.tap(find.byType(StatCard));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    return landed;
  }

  testWidgets('a card for a visible module navigates', (tester) async {
    final landed = await tapCard(
      tester,
      const LinkedStatCard(
        label: 'Members',
        value: '12',
        route: '/members',
        module: 'Members',
        tooltip: 'Open the member directory',
        accent: AppTheme.info,
      ),
    );
    expect(landed, '/members');
  });

  testWidgets('a card for a switched-off module does nothing', (tester) async {
    final landed = await tapCard(
      tester,
      const LinkedStatCard(
        label: 'Giving',
        value: 'GH₵0',
        route: '/finance',
        module: 'Giving & Finance',
        tooltip: 'Open giving',
        accent: AppTheme.warning,
      ),
    );
    expect(landed, isNull,
        reason: 'Finance is switched off, so the card must be inert');
  });

  testWidgets('an inert card is not tinted either', (tester) async {
    // Colour is the signal that a card does something, so a card that cannot
    // navigate must not keep the accent that implies it can.
    final container =
        ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(container.dispose);
    container.read(sessionProvider.notifier).refresh(admin);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: LinkedStatCard(
            label: 'Giving',
            value: 'GH₵0',
            route: '/finance',
            module: 'Giving & Finance',
            tooltip: 'Open giving',
            accent: AppTheme.warning,
          ),
        ),
      ),
    ));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    final card = tester.widget<StatCard>(find.byType(StatCard));
    expect(card.accent, isNull);
    expect(card.onTap, isNull);
    expect(card.tooltip, isNull);
  });

  testWidgets('a plain card has no ripple to promise a tap', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.light(),
      home: const Scaffold(
        body: StatCard(label: 'Families', value: '4'),
      ),
    ));
    await tester.pump();

    final inkWell = tester.widget<InkWell>(find.descendant(
      of: find.byType(StatCard),
      matching: find.byType(InkWell),
    ));
    expect(inkWell.onTap, isNull);
  });
}
