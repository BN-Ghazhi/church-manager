import 'package:churchms/db/database.dart';
import 'package:churchms/db/password.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/providers/auth.dart';
import 'package:churchms/theme/app_theme.dart';
import 'package:churchms/utils/formatters.dart';
import 'package:churchms/widgets/member_form.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

/// The Title field is for church office only.
///
/// Validated here rather than only against MemberTitle, because a rule the model
/// enforces but the form never calls is a rule nobody sees.
void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('the title field refuses a civil title and shows why', (t) async {
    initializeDateFormatting(Fmt.locale);
    Password.useFastHashingForTests();

    t.view.physicalSize = const Size(1400, 1300);
    t.view.devicePixelRatio = 1.0;
    addTearDown(t.view.reset);

    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await TestSetup.run(db);
    final admin = (await ChurchRepository(db)
        .signIn(TestSetup.username, TestSetup.password))!;

    final container =
        ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
    addTearDown(container.dispose);
    container.read(sessionProvider.notifier).refresh(admin);

    await t.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light(),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => showMemberForm(context),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    await t.tap(find.text('open'));
    for (var i = 0; i < 10; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }

    // The title is the first field on the form.
    await t.enterText(find.byType(TextFormField).first, 'Mr');
    for (var i = 0; i < 5; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }

    // Validate the form directly rather than submitting: a real save writes to
    // the database, which deadlocks under the widget-test fake clock.
    final form = t.state<FormState>(find.byType(Form));
    expect(form.validate(), isFalse, reason: '"Mr" must not pass validation');
    for (var i = 0; i < 5; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(find.textContaining('church office only'), findsOneWidget,
        reason: 'the reason must be visible, not a silent refusal');

    // Fill the required name fields too, so "still invalid" can only mean the
    // title.
    final fields = find.byType(TextFormField);
    await t.enterText(fields.at(0), 'Associate Pastor');
    await t.enterText(fields.at(1), 'Kofi');
    await t.enterText(fields.at(2), 'Owusu');
    for (var i = 0; i < 5; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(form.validate(), isTrue,
        reason: 'a church title with the names filled in is valid');
    for (var i = 0; i < 5; i++) {
      await t.pump(const Duration(milliseconds: 100));
    }
    expect(find.textContaining('church office only'), findsNothing);
  });
}
