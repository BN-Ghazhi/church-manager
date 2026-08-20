import 'package:churchms/db/database.dart';
import 'package:churchms/db/repository.dart';
import 'package:churchms/models/models.dart';
import 'package:churchms/widgets/contact_link.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Editing a branch, and turning its contact details into openable links.
void main() {
  late AppDatabase db;
  late ChurchRepository repo;
  late String branchId;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = ChurchRepository(db);
    branchId = await repo.createBranch(
      name: 'Kumasi Campus',
      code: 'ksi',
      addressLine: '4 Prempeh Street',
      city: 'Kumasi',
      state: 'Ashanti',
      status: BranchStatus.planting,
      establishedAt: DateTime.utc(2023, 4, 1),
      accent: AccentToken.blue,
    );
  });

  tearDown(() => db.close());

  Future<Branch> read() async =>
      (await repo.watchBranches().first).firstWhere((b) => b.id == branchId);

  test('every field on the edit form actually persists', () async {
    await repo.updateBranch(
      branchId,
      name: 'Kumasi Central',
      code: 'kct',
      addressLine: '9 Bantama High Street',
      city: 'Bantama',
      state: 'Ashanti',
      status: BranchStatus.active,
      accent: AccentToken.violet,
      establishedAt: DateTime.utc(2022, 1, 9),
      phone: '+233 24 111 2222',
      email: 'kumasi@kgc.org',
      website: 'kgc.org/kumasi',
    );

    final b = await read();
    expect(b.name, 'Kumasi Central');
    // Codes are upper-cased on write, so tables stay tidy whatever was typed.
    expect(b.code, 'KCT');
    expect(b.address.line1, '9 Bantama High Street');
    expect(b.address.city, 'Bantama');
    expect(b.status, BranchStatus.active);
    expect(b.accent, AccentToken.violet);
    expect(b.establishedAt, DateTime.utc(2022, 1, 9));
    expect(b.phone, '+233 24 111 2222');
    expect(b.email, 'kumasi@kgc.org');
    expect(b.website, 'kgc.org/kumasi');
  });

  test('an omitted field is left alone rather than blanked', () async {
    await repo.updateBranch(branchId, phone: '024 000 1111');
    await repo.updateBranch(branchId, name: 'Renamed');

    final b = await read();
    expect(b.name, 'Renamed');
    expect(b.phone, '024 000 1111',
        reason: 'a second edit must not wipe the first');
    expect(b.accent, AccentToken.blue);
  });

  test('a new branch starts with no contact details', () async {
    final b = await read();
    expect(b.phone, isEmpty);
    expect(b.email, isEmpty);
    expect(b.website, isEmpty);
  });

  group('contact links', () {
    test('a phone number loses its spaces so tel: accepts it', () {
      expect(
        ContactKind.phone.uriFor('+233 24 123 4567').toString(),
        'tel:+233241234567',
      );
    });

    test('a bare domain gains a scheme', () {
      // Without this, "kgc.org" is read as a relative path and never opens.
      expect(
        ContactKind.website.uriFor('kgc.org/accra').toString(),
        'https://kgc.org/accra',
      );
      expect(
        ContactKind.website.uriFor('https://kgc.org').toString(),
        'https://kgc.org',
      );
    });

    test('an email becomes a mailto', () {
      expect(
        ContactKind.email.uriFor('accra@kgc.org').toString(),
        'mailto:accra@kgc.org',
      );
    });

    test('an address becomes a maps search', () {
      final uri = ContactKind.map.uriFor('4 Prempeh Street, Kumasi')!;
      expect(uri.host, 'www.google.com');
      expect(uri.queryParameters['query'], '4 Prempeh Street, Kumasi');
    });

    test('a blank value produces no link at all', () {
      for (final kind in ContactKind.values) {
        expect(kind.uriFor(''), isNull, reason: kind.name);
        expect(kind.uriFor('   '), isNull, reason: kind.name);
      }
    });
  });
}
