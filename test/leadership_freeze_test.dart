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
    await repo.watchBranches().first;
    admin = (await repo.signIn(
        Seeder.firstAdminUsername, Seeder.firstAdminPassword))!;

    // A second branch with no pastor, matching the real install.
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

  testWidgets('Edit leadership from the branch modal opens the form',
      (tester) async {
    tester.view.physicalSize = const Size(1800, 1400);
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
        // A route beneath, the way the app shell provides one. Popping the
        // wrong context takes this away instead of the dialog.
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Scaffold(body: BranchesScreen()),
                  ),
                ),
                child: const Text('open branches'),
              ),
            ),
          ),
        ),
      ),
    ));
    await settle(tester);
    await tester.tap(find.text('open branches'));
    await settle(tester);

    await tester.tap(find.byTooltip('View').first);
    await settle(tester);
    expect(find.text('Leadership'), findsOneWidget);

    await tester.tap(find.text('Leadership'));
    await settle(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Branch leadership'), findsOneWidget);

    // Exactly one dialog. The bug here was the detail sheet staying open behind
    // the form: its modal barrier then ate every click, which looked like the
    // whole app freezing. Two copies of a field is the fingerprint.
    // The detail sheet is gone: its own buttons are no longer in the tree.
    // If it had stayed open behind the form, its modal barrier would swallow
    // every click — which is what read as the app freezing.
    expect(find.text('Focus this branch'), findsNothing,
        reason: 'the detail sheet must close, not stack behind the form');
    expect(find.text('Leadership'), findsNothing);

    // And the screen underneath survived — the pop must take the sheet, not the
    // route the sheet was opened from.
    expect(find.byType(BranchesScreen), findsOneWidget);
  });
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
