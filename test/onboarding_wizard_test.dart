import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/screens/onboarding_screen.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/utils/formatters.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

/// First-run setup is the only way into a fresh install, so it has to work.
void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('the setup wizard collects the church then the account',
      (t) async {
    initializeDateFormatting(Fmt.locale);
    Password.useFastHashingForTests();
    t.view.physicalSize = const Size(900, 1100);
    t.view.devicePixelRatio = 1.0;
    addTearDown(t.view.reset);

    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await Seeder(db).seedFirstRun();

    final c = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(c.dispose);

    await t.pumpWidget(UncontrolledProviderScope(
      container: c,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const OnboardingScreen(),
      ),
    ));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('Welcome'), findsOneWidget);
    // Church name, short name, branch name.
    expect(find.byType(TextFormField), findsNWidgets(3));

    // Typing the church name should fill the derived fields.
    await t.enterText(find.byType(TextFormField).at(0), 'Kingdom Grace Chapel');
    for (var i = 0; i < 5; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }

    // The short name and branch are derived, so most churches type once.
    final short = t.widget<TextFormField>(find.byType(TextFormField).at(1));
    final branch = t.widget<TextFormField>(find.byType(TextFormField).at(2));
    expect(short.controller?.text, 'K.G.C.');
    expect(branch.controller?.text, 'Kingdom Grace Chapel Headquarters');

    await t.tap(find.text('Continue'));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(t.takeException(), isNull);
    expect(find.text('Finish setup'), findsOneWidget);
    // Name, username, password, confirm.
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Confirm password'), findsOneWidget);
  });
}
