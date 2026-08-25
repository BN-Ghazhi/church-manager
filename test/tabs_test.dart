import 'package:google_fonts/google_fonts.dart';

import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/screens/members_screen.dart';
import 'package:churchms/screens/settings_screen.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/utils/formatters.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  late AppDatabase db;
  late StaffUser admin;

  setUpAll(() {
    initializeDateFormatting(Fmt.locale);
    Password.useFastHashingForTests();
  });

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    final repo = ChurchRepository(db);
    await TestSetup.run(db);
    final hq = (await repo.watchBranches().first).single.id;
    admin = (await repo.signIn(
        TestSetup.username, TestSetup.password))!;

    final pastor = await repo.createMember(
      branchId: hq, firstName: 'Samuel', lastName: 'Mensah',
      gender: Gender.male, dateOfBirth: DateTime.utc(1975, 3, 2),
      maritalStatus: MaritalStatus.married, status: MemberStatus.active,
      isBaptized: true, phone: '+233 24 111 2222',
    );
    await repo.setBranchLeadership(hq, pastorId: pastor);

    final types = await repo.watchDepartmentTypes().first;
    final dept = await repo.createDepartment(
      branchId: hq, typeId: types.first.id, headId: pastor,
      meetingDay: Weekday.sunday, meetingTime: '9:00 AM',
    );
    expect(dept, isNotEmpty);
  });

  tearDown(() => db.close());

  /// Pumps one screen with a signed-in Super Admin.
  Future<void> open(WidgetTester tester, Widget screen) async {
    tester.view.physicalSize = const Size(1500, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final container =
        ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(container.dispose);
    container.read(sessionProvider.notifier).refresh(admin);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: AppTheme.light(), home: Scaffold(body: screen)),
    ));
    for (var i = 0; i < 15; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(tester.takeException(), isNull);
  }

  testWidgets('Members opens on the directory and has a Pastors tab',
      (t) async {
    await open(t, const MembersScreen());

    expect(find.text('Directory'), findsOneWidget);
    expect(find.textContaining('Pastors & leaders'), findsOneWidget);
    // The directory is the landing tab, so its table is what you see first.
    expect(find.text('Member directory'), findsOneWidget);
    expect(find.text('Leadership'), findsNothing);
  });

  testWidgets('the Pastors tab lists who leads what', (t) async {
    await open(t, const MembersScreen());
    await t.tap(find.textContaining('Pastors & leaders'));
    for (var i = 0; i < 15; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(t.takeException(), isNull);

    expect(find.text('Pastors & leaders'), findsWidgets);
    expect(find.text('Leadership'), findsOneWidget);
    // The seeded fixture appoints one person to two posts.
    expect(find.textContaining('Branch pastor · '), findsWidgets);
    expect(find.text('Appoint a leader'), findsOneWidget);
  });

  testWidgets('Settings is four tabs rather than one long scroll', (t) async {
    await open(t, const SettingsScreen());

    for (final tab in ['Church', 'Appearance', 'Preferences', 'Data']) {
      expect(find.text(tab), findsWidgets, reason: tab);
    }

    // The Church tab is showing, so a section from another tab is not built.
    expect(find.text('Church details'), findsOneWidget);
    expect(find.text('Branding'), findsNothing);

    await t.tap(find.text('Appearance').first);
    for (var i = 0; i < 15; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(t.takeException(), isNull);
    expect(find.text('Branding'), findsOneWidget);

    await t.tap(find.text('Data').first);
    for (var i = 0; i < 15; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(t.takeException(), isNull);
    // The old label promised sample data the app no longer ships.
    expect(find.text('Erase all records'), findsOneWidget);
    expect(find.textContaining('demo data'), findsNothing);
  });
}
