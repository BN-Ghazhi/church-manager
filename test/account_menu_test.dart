import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/db/seeder.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/shell/user_switcher.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/utils/formatters.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Change password is reachable from the account menu', (t) async {
    initializeDateFormatting(Fmt.locale);
    Password.useFastHashingForTests();
    t.view.physicalSize = const Size(1000, 900);
    t.view.devicePixelRatio = 1.0;
    addTearDown(t.view.reset);

    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await Seeder(db).seedFirstRun();
    final admin = (await ChurchRepository(db)
        .signIn(Seeder.firstAdminUsername, Seeder.firstAdminPassword))!;

    final c = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(c.dispose);
    c.read(sessionProvider.notifier).refresh(admin);

    await t.pumpWidget(UncontrolledProviderScope(
      container: c,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: SizedBox(width: 260, child: UserSwitcher()),
        ),
      ),
    ));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }

    await t.tap(find.byType(UserSwitcher));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(find.text('Change password'), findsOneWidget,
        reason: 'every account must be able to change its own password — the '
            'first-run one is published in the repository');

    await t.tap(find.text('Change password'));
    for (var i = 0; i < 12; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }

    expect(t.takeException(), isNull);
    expect(find.text('Change your password'), findsOneWidget);
    // Asking for the current password is what stops someone at an unlocked
    // machine locking the real user out.
    expect(find.text('Current password'), findsOneWidget);
    expect(find.text('Confirm new password'), findsOneWidget);
  });
}
