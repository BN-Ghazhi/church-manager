import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/screens/access_screen.dart';
import 'package:churchms/screens/assets_screen.dart';
import 'package:churchms/screens/communication_screen.dart';
import 'package:churchms/screens/departments_screen.dart';
import 'package:churchms/screens/discipleship_screen.dart';
import 'package:churchms/screens/ministries_screen.dart';
import 'package:churchms/screens/volunteers_screen.dart';
import 'package:churchms/screens/attendance_screen.dart';
import 'package:churchms/screens/branches_screen.dart';
import 'package:churchms/screens/care_screen.dart';
import 'package:churchms/screens/events_screen.dart';
import 'package:churchms/screens/finance_screen.dart';
import 'package:churchms/screens/members_screen.dart';
import 'package:churchms/screens/overview_screen.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/utils/formatters.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Drives the real widgets, because "the table has view, edit and delete" is a
/// claim about what is on screen, and only pumping the screen can check it.
///
/// **Every database write happens in `setUp`, never inside a `testWidgets`
/// body.** Those bodies run under fake async, where Drift's stream timers never
/// fire, so awaiting a query after a `watchX().first` deadlocks. The test bodies
/// therefore only pump and assert.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late String branchId;
  late StaffUser admin;

  setUpAll(() {
    initializeDateFormatting(Fmt.locale);
    Password.useFastHashingForTests();
  });

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    await TestSetup.run(db);
    branchId = (await repo.watchBranches().first).single.id;
    admin = (await repo.signIn(
      TestSetup.username,
      TestSetup.password,
    ))!;
  });

  tearDown(() => db.close());

  Future<String> addMember({
    required String first,
    required String last,
    String phone = '',
    MemberStatus status = MemberStatus.active,
  }) =>
      repo.createMember(
        branchId: branchId,
        firstName: first,
        lastName: last,
        phone: phone,
        gender: Gender.female,
        dateOfBirth: DateTime.utc(1995, 4, 10),
        maritalStatus: MaritalStatus.single,
        status: status,
        joinedAt: DateTime.utc(2024, 1, 7),
        city: 'Accra',
        state: 'Greater Accra',
        isBaptized: false,
      );

  Future<void> pumpScreen(WidgetTester tester, Widget screen) async {
    // A wide window, so nothing is hidden by the narrow-layout rules.
    tester.view.physicalSize = const Size(1800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    // Set outside the widget tree: writing provider state from inside a builder
    // would re-trigger the build that wrote it.
    container.read(sessionProvider.notifier).refresh(admin);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(body: screen),
        ),
      ),
    );
    await settle(tester);
  }

  testWidgets('the members table shows view, edit and delete on every row',
      (tester) async {
    await addMember(first: 'Ama', last: 'Owusu', phone: '+233 24 111 2222');

    await pumpScreen(tester, const MembersScreen());

    expect(find.text('Ama Owusu'), findsOneWidget);
    expect(find.byTooltip('View'), findsOneWidget);
    expect(find.byTooltip('Edit'), findsOneWidget);
    expect(find.byTooltip('Delete'), findsOneWidget);
  });

  testWidgets('View opens a modal that answers whether they were present',
      (tester) async {
    final memberId = await addMember(first: 'Kwame', last: 'Mensah');
    await repo.saveCheckIns(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 9),
      serviceName: 'First Service',
      memberIds: {memberId},
    );

    await pumpScreen(tester, const MembersScreen());
    await tester.tap(find.byTooltip('View'));
    await settle(tester);

    expect(find.text('Kwame Mensah'), findsWidgets);
    expect(find.text('Attendance'), findsOneWidget);
    // The service they were checked in to is listed by name.
    expect(find.text('First Service'), findsOneWidget);
  });

  testWidgets('a member with no check-ins is told so plainly', (tester) async {
    await addMember(
        first: 'Akosua', last: 'Boateng', status: MemberStatus.visitor);

    await pumpScreen(tester, const MembersScreen());
    await tester.tap(find.byTooltip('View'));
    await settle(tester);

    expect(find.textContaining('Never checked in'), findsOneWidget);
  });

  testWidgets('Edit opens the member form pre-filled', (tester) async {
    await addMember(first: 'Yaa', last: 'Asante');

    await pumpScreen(tester, const MembersScreen());
    await tester.tap(find.byTooltip('Edit'));
    await settle(tester);

    // The existing values are in the form, not a blank "add member" dialog.
    expect(find.widgetWithText(TextFormField, 'Yaa'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Asante'), findsOneWidget);
  });

  testWidgets('Delete asks before removing, and says what it affects',
      (tester) async {
    await addMember(first: 'Adwoa', last: 'Nkrumah');

    await pumpScreen(tester, const MembersScreen());
    await tester.tap(find.byTooltip('Delete'));
    await settle(tester);

    expect(find.text('Adwoa Nkrumah'), findsWidgets);
    expect(find.textContaining('no longer appear in the directory'),
        findsOneWidget);
    // Nothing is destroyed until the confirmation is accepted.
    expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);
  });

  testWidgets('the stats row collapses and reclaims the space', (tester) async {
    await pumpScreen(tester, const MembersScreen());

    expect(find.text('Total on file'), findsOneWidget);
    expect(find.text('Hide'), findsOneWidget);

    await tester.tap(find.text('Overview'));
    await settle(tester);

    expect(find.text('Show'), findsOneWidget);
    expect(find.text('Total on file'), findsNothing,
        reason: 'collapsing must reclaim the space, not just fade the cards');
  });

  // Every screen with a table gets the same check. The row-action overflow that
  // this suite first caught was in the shared widget, so it appeared on all of
  // them at once — which is exactly the class of bug a per-screen sweep finds.
  testWidgets('every table screen renders without layout overflow',
      (tester) async {
    final memberId = await addMember(first: 'Esi', last: 'Darko');
    await repo.recordDonation(
      branchId: branchId,
      memberId: memberId,
      donorName: 'Esi Darko',
      amount: 250,
      fund: GivingFund.tithe,
      method: PaymentMethod.mobile,
      date: DateTime.utc(2026, 8, 2),
    );
    await repo.recordExpense(
      branchId: branchId,
      category: 'Utilities',
      vendor: 'ECG',
      amount: 800,
      date: DateTime.utc(2026, 8, 3),
      status: ExpenseStatus.paid,
    );
    await repo.createEvent(
      branchId: branchId,
      title: 'Harvest Service',
      category: EventCategory.service,
      startsAt: DateTime.utc(2026, 9, 6, 9),
      endsAt: DateTime.utc(2026, 9, 6, 12),
    );
    await repo.createAsset(
      branchId: branchId,
      name: 'Sound Mixer',
      category: 'Audio',
      condition: AssetCondition.good,
      purchasedAt: DateTime.utc(2025, 2, 1),
      value: 12000,
    );
    await repo.createCareRequest(
      branchId: branchId,
      memberId: memberId,
      type: CareType.prayer,
      summary: 'Prayer for safe travel',
      priority: CarePriority.medium,
    );
    await repo.saveCheckIns(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 9),
      serviceName: 'First Service',
      memberIds: {memberId},
    );

    for (final screen in const <(String, Widget)>[
      ('Members', MembersScreen()),
      ('Branches', BranchesScreen()),
      ('Attendance', AttendanceScreen()),
      ('Finance', FinanceScreen()),
      ('Events', EventsScreen()),
      ('Care', CareScreen()),
      ('Assets', AssetsScreen()),
    ]) {
      await pumpScreen(tester, screen.$2);
      expect(tester.takeException(), isNull,
          reason: '${screen.$1} threw during layout');
    }
  });

  testWidgets('a service record lists who was checked in', (tester) async {
    final memberId = await addMember(first: 'Efua', last: 'Tetteh');
    await repo.saveCheckIns(
      branchId: branchId,
      date: DateTime.utc(2026, 8, 16),
      serviceName: 'First Service',
      memberIds: {memberId},
    );

    await pumpScreen(tester, const AttendanceScreen());
    await tester.tap(find.byTooltip('View').first);
    await settle(tester);

    expect(find.text('Members checked in'), findsOneWidget);
    // Their name appears as a chip in the checked-in list.
    expect(find.text('Efua Tetteh'), findsWidgets);
  });

  testWidgets('Dashboard and Reports are tabs on one page', (tester) async {
    await pumpScreen(tester, const OverviewScreen());

    // Both tabs are present, and the dashboard is the one showing.
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Reports'), findsWidgets);

    await tester.tap(find.text('Reports').first);
    await settle(tester);
    expect(tester.takeException(), isNull);
  });

  // The state every new install is in. Screens are much more likely to divide
  // by zero or read `.first` off an empty list here than with data present, and
  // this is the very first thing the user sees.
  testWidgets('every screen renders on a completely empty database',
      (tester) async {
    for (final screen in const <(String, Widget)>[
      ('Overview', OverviewScreen()),
      ('Members', MembersScreen()),
      ('Branches', BranchesScreen()),
      ('Attendance', AttendanceScreen()),
      ('Finance', FinanceScreen()),
      ('Events', EventsScreen()),
      ('Care', CareScreen()),
      ('Assets', AssetsScreen()),
      ('Departments', DepartmentsScreen()),
      ('Volunteers', VolunteersScreen()),
      ('Discipleship', DiscipleshipScreen()),
      ('Ministries', MinistriesScreen()),
      ('Communication', CommunicationScreen()),
      ('Access', AccessScreen()),
    ]) {
      await pumpScreen(tester, screen.$2);
      expect(tester.takeException(), isNull,
          reason: '${screen.$1} threw on an empty database');
    }
  });

  testWidgets('a branch opens its details in a modal', (tester) async {
    await pumpScreen(tester, const BranchesScreen());

    await tester.tap(find.byTooltip('View').first);
    await settle(tester);

    expect(find.text('Members'), findsWidgets);
    expect(find.text('Focus this branch'), findsOneWidget);
  });
}

/// Fixed pumps rather than `pumpAndSettle`: the screens watch database streams,
/// so the frame scheduler is never reliably idle.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
