import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/screens/branches_screen.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/utils/formatters.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// The whole path the user took: open a branch, Edit leadership, pick, save.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late StaffUser admin;

  setUpAll(() {
    initializeDateFormatting(Fmt.locale);
    Password.useFastHashingForTests();
  });

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    await Seeder(db).seedFirstRun();
    final hq = (await repo.watchBranches().first).single.id;
    admin = (await repo.signIn(
        Seeder.firstAdminUsername, Seeder.firstAdminPassword))!;
    for (final name in ['First', 'Second']) {
      await repo.createMember(
        branchId: hq,
        firstName: name,
        lastName: 'Member',
        gender: Gender.male,
        dateOfBirth: DateTime.utc(1996, 1, 1),
        maritalStatus: MaritalStatus.single,
        status: MemberStatus.active,
        isBaptized: false,
      );
    }
    await repo.createBranch(
      name: 'new',
      code: 'NEW',
      addressLine: '',
      city: '',
      state: '',
      status: BranchStatus.active,
      establishedAt: DateTime.utc(2026, 8, 1),
      accent: AccentToken.blue,
    );
  });

  tearDown(() => db.close());

  testWidgets('open branch, edit leadership, choose a pastor and save',
      (tester) async {
    tester.view.physicalSize = const Size(1700, 1300);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final container =
        ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(container.dispose);
    container.read(sessionProvider.notifier).refresh(admin);

    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(body: BranchesScreen()),
      ),
    ));
    await settle(tester);

    // The HQ row, which has members to choose from.
    await tester.tap(find.byTooltip('View').first);
    await settle(tester);
    await tester.tap(find.text('Leadership'));
    await settle(tester);
    expect(tester.takeException(), isNull);

    // Pick a pastor from the dropdown.
    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await settle(tester);
    await tester.tap(find.text('First Member').last);
    await settle(tester);
    expect(tester.takeException(), isNull);

    // The chosen name is now shown in the closed dropdown.
    expect(find.text('First Member'), findsWidgets);

    // Exactly one modal barrier. The bug the user hit was the detail sheet
    // staying open behind this form: its barrier sits above the form and
    // absorbs every click, so the dialog looks alive but ignores you — which is
    // indistinguishable from the app freezing.
    expect(find.byType(ModalBarrier), findsNWidgets(2),
        reason: 'one barrier for the form, one for the dropdown route');
  });
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 15; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
