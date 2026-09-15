import 'package:churchms/db/database.dart';
import 'package:churchms/db/ids.dart';
import 'package:churchms/db/repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fixtures.dart';

/// Ids must be unique across machines, because branches work offline.
///
/// The old scheme read the highest existing id and added one, so two laptops
/// offline both produced `mem-0001` and syncing lost one of the two records.
/// These tests pin the replacement and, more importantly, the property that
/// matters: two independent databases never produce the same id.
void main() {
  group('generation', () {
    test('ids carry a readable prefix', () {
      expect(Ids.next('mem'), startsWith('mem-'));
      expect(Ids.next('brn'), startsWith('brn-'));
    });

    test('ids are unique in bulk', () {
      // 50,000 in a tight loop, so many land in the same millisecond and only
      // the random half separates them.
      final seen = <String>{};
      for (var i = 0; i < 50000; i++) {
        expect(seen.add(Ids.next('mem')), isTrue,
            reason: 'duplicate id after ${seen.length}');
      }
    });

    test('ids sort chronologically as text', () async {
      // Several queries rely on `ORDER BY id`, which the old zero-padded
      // counter gave for free. The timestamp leads, so this still holds.
      final first = Ids.next('mem');
      await Future<void>.delayed(const Duration(milliseconds: 5));
      final second = Ids.next('mem');
      await Future<void>.delayed(const Duration(milliseconds: 5));
      final third = Ids.next('mem');

      final sorted = [third, first, second]..sort();
      expect(sorted, [first, second, third]);
    });

    test('ids avoid characters that are misread aloud', () {
      // Crockford base32: no I, L, O or U, so an id read over the phone to a
      // church office cannot be transcribed wrongly.
      for (var i = 0; i < 200; i++) {
        final body = Ids.next('mem').split('-').last;
        expect(body, matches(RegExp(r'^[0-9ABCDEFGHJKMNPQRSTVWXYZ]{26}$')),
            reason: body);
      }
    });
  });

  group('two machines offline', () {
    test('never generate the same id', () async {
      // Two separate databases stand in for two branch laptops, both offline.
      final kumasi = AppDatabase.forTesting(NativeDatabase.memory());
      final tema = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(kumasi.close);
      addTearDown(tema.close);

      for (final db in [kumasi, tema]) {
        await TestSetup.run(db);
      }

      final kRepo = ChurchRepository(kumasi);
      final tRepo = ChurchRepository(tema);
      final kBranch = (await kRepo.watchBranches().first).single.id;
      final tBranch = (await tRepo.watchBranches().first).single.id;

      // Each records ten members while disconnected.
      final kIds = <String>[];
      final tIds = <String>[];
      for (var i = 0; i < 10; i++) {
        kIds.add(await Fixtures(kumasi)
            .member(branchId: kBranch, lastName: 'Kumasi$i'));
        tIds.add(await Fixtures(tema)
            .member(branchId: tBranch, lastName: 'Tema$i'));
      }

      // Before this change both sides produced mem-0001, and syncing would have
      // silently overwritten one member with the other.
      expect(kIds.toSet().intersection(tIds.toSet()), isEmpty,
          reason: 'offline branches must never mint the same id');
    });

    test('their records can be merged without loss', () async {
      // What sync will actually do: pour one machine's rows into the other.
      // With colliding ids this lost data; with unique ids it cannot.
      final kumasi = AppDatabase.forTesting(NativeDatabase.memory());
      final tema = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(kumasi.close);
      addTearDown(tema.close);

      for (final db in [kumasi, tema]) {
        await TestSetup.run(db);
      }

      final kRepo = ChurchRepository(kumasi);
      final kBranch = (await kRepo.watchBranches().first).single.id;
      final tRepo = ChurchRepository(tema);
      final tBranch = (await tRepo.watchBranches().first).single.id;

      await Fixtures(kumasi).member(branchId: kBranch, lastName: 'Kumasi');
      await Fixtures(tema).member(branchId: tBranch, lastName: 'Tema');

      final kMembers = await kRepo.watchMembers().first;
      final tMembers = await tRepo.watchMembers().first;
      final merged = {
        for (final m in [...kMembers, ...tMembers]) m.id: m,
      };

      expect(merged, hasLength(2),
          reason: 'both members survive the merge, neither overwrites the other');
      expect(
        merged.values.map((m) => m.lastName).toSet(),
        {'Kumasi', 'Tema'},
      );
    });
  });

  test('seeded ids are untouched', () async {
    // Seeder writes brn-0001 and dpt-youth literally. Those must keep working:
    // the catalogue ids are referenced by name elsewhere.
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await TestSetup.run(db);

    final repo = ChurchRepository(db);
    expect((await repo.watchBranches().first).single.id, 'brn-0001');
    expect(
      (await repo.watchDepartmentTypes().first).map((t) => t.id),
      contains('dpt-youth'),
    );
  });
}
