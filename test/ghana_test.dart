import 'package:churchms/config/ghana.dart';
import 'package:churchms/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Ghana-specific behaviour: regions rather than states, and phone numbers in
/// the forms people actually type them.
void main() {
  group('regions', () {
    test('there are sixteen, and no duplicates', () {
      expect(Ghana.regions, hasLength(16));
      expect(Ghana.regionNames.toSet(), hasLength(16));
    });

    test('the six regions created in 2018 are present', () {
      // These are the ones an older list would be missing.
      for (final region in [
        'Ahafo', 'Bono East', 'North East', 'Oti', 'Savannah', 'Western North',
      ]) {
        expect(Ghana.regionNames, contains(region), reason: region);
      }
    });

    test('no region is called a state', () {
      for (final region in Ghana.regionNames) {
        expect(region.toLowerCase(), isNot(contains('state')));
      }
      expect(Ghana.regionLabel, 'Region');
    });

    test('a region is recognised regardless of case or spacing', () {
      expect(Ghana.isRegion('Greater Accra'), isTrue);
      expect(Ghana.isRegion('  greater accra '), isTrue);
      expect(Ghana.isRegion('Lagos'), isFalse);
    });
  });

  group('inferring a region from a city', () {
    test('regional capitals resolve', () {
      expect(Ghana.regionForCity('Accra'), 'Greater Accra');
      expect(Ghana.regionForCity('Kumasi'), 'Ashanti');
      expect(Ghana.regionForCity('Tamale'), 'Northern');
      expect(Ghana.regionForCity('Ho'), 'Volta');
    });

    test('common non-capital towns resolve', () {
      expect(Ghana.regionForCity('Tema'), 'Greater Accra');
      expect(Ghana.regionForCity('Obuasi'), 'Ashanti');
      expect(Ghana.regionForCity('Takoradi'), 'Western');
      expect(Ghana.regionForCity('Kasoa'), 'Central');
    });

    test('case and surrounding spaces do not matter', () {
      expect(Ghana.regionForCity('  kUmAsI  '), 'Ashanti');
    });

    test('an unknown or empty city returns null rather than guessing', () {
      expect(Ghana.regionForCity('Nowheresville'), isNull);
      expect(Ghana.regionForCity(''), isNull);
      expect(Ghana.regionForCity('   '), isNull);
    });
  });

  group('phone numbers', () {
    test('the forms people type all normalise to one', () {
      const expected = '+233 24 123 4567';
      for (final input in [
        '0241234567',
        '024 123 4567',
        '024-123-4567',
        '241234567',
        '+233241234567',
        '+233 24 123 4567',
        '233241234567',
      ]) {
        expect(Ghana.formatPhone(input), expected, reason: input);
      }
    });

    test('every network prefix is accepted', () {
      for (final prefix in Ghana.mobilePrefixes) {
        expect(
          Ghana.formatPhone('0${prefix}1234567'),
          '+233 $prefix 123 4567',
          reason: prefix,
        );
      }
    });

    test('a number that is not a Ghanaian mobile is left alone', () {
      // Better to store what was entered than to mangle a landline or a number
      // from abroad into a shape it does not have.
      expect(Ghana.formatPhone('+44 20 7946 0958'), '+44 20 7946 0958');
      expect(Ghana.formatPhone('030 123 4567'), '030 123 4567');
      expect(Ghana.formatPhone('12345'), '12345');
    });

    test('blank is allowed — not every member has a phone', () {
      expect(Ghana.validatePhone(''), isNull);
      expect(Ghana.validatePhone(null), isNull);
    });

    test('something far too short is rejected', () {
      expect(Ghana.validatePhone('0241'), isNotNull);
    });

    test('a valid number passes validation', () {
      expect(Ghana.validatePhone('0241234567'), isNull);
      expect(Ghana.validatePhone('+233 24 123 4567'), isNull);
    });
  });

  group('addresses', () {
    test('region is the term used in code', () {
      const address = Address(
        line1: '14 Ring Road Central',
        city: 'Accra',
        state: 'Greater Accra',
      );
      expect(address.region, 'Greater Accra');
      expect(address.country, 'Ghana');
    });

    test('blank parts do not leave stray commas', () {
      const partial = Address(line1: '', city: 'Kumasi', state: '');
      expect(partial.short, 'Kumasi');
      expect(partial.full, 'Kumasi, Ghana');

      const empty = Address(line1: '', city: '', state: '');
      expect(empty.short, '');
      expect(empty.full, 'Ghana');
    });

    test('a full address reads in order', () {
      const address = Address(
        line1: '14 Ring Road Central',
        city: 'Accra',
        state: 'Greater Accra',
      );
      expect(address.full, '14 Ring Road Central, Accra, Greater Accra, Ghana');
    });
  });
}
