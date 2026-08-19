/// Ghana-specific reference data.
///
/// Ghana has **regions**, not states — sixteen of them since the 2018
/// reorganisation that created six new ones. Free-typing them invites
/// inconsistency ("Gt. Accra", "greater accra", "Accra Region") which then
/// breaks grouping and reporting, so addresses pick from this list.
class Ghana {
  const Ghana._();

  static const country = 'Ghana';

  /// The administrative term Ghana uses. Shown as a field label so the app does
  /// not ask a Ghanaian church for a "state".
  static const regionLabel = 'Region';

  /// All sixteen regions, alphabetical, with their capitals.
  ///
  /// Ordered alphabetically rather than by size so the list is predictable to
  /// scan; Greater Accra is not privileged just because headquarters is there.
  static const regions = <GhanaRegion>[
    GhanaRegion('Ahafo', 'Goaso'),
    GhanaRegion('Ashanti', 'Kumasi'),
    GhanaRegion('Bono', 'Sunyani'),
    GhanaRegion('Bono East', 'Techiman'),
    GhanaRegion('Central', 'Cape Coast'),
    GhanaRegion('Eastern', 'Koforidua'),
    GhanaRegion('Greater Accra', 'Accra'),
    GhanaRegion('North East', 'Nalerigu'),
    GhanaRegion('Northern', 'Tamale'),
    GhanaRegion('Oti', 'Dambai'),
    GhanaRegion('Savannah', 'Damongo'),
    GhanaRegion('Upper East', 'Bolgatanga'),
    GhanaRegion('Upper West', 'Wa'),
    GhanaRegion('Volta', 'Ho'),
    GhanaRegion('Western', 'Sekondi-Takoradi'),
    GhanaRegion('Western North', 'Wiawso'),
  ];

  static List<String> get regionNames =>
      regions.map((r) => r.name).toList(growable: false);

  /// True when [value] is one of the sixteen regions.
  static bool isRegion(String value) =>
      regions.any((r) => r.name.toLowerCase() == value.trim().toLowerCase());

  /// The region a well-known city sits in, so the picker can pre-select itself
  /// once a city has been typed. Returns null when the city is not recognised —
  /// a guess would be worse than leaving it to the user.
  static String? regionForCity(String city) {
    final needle = city.trim().toLowerCase();
    if (needle.isEmpty) return null;

    for (final region in regions) {
      if (region.capital.toLowerCase() == needle) return region.name;
    }
    return _otherCities[needle];
  }

  /// Cities that are not regional capitals but common enough to map.
  static const _otherCities = <String, String>{
    'tema': 'Greater Accra',
    'madina': 'Greater Accra',
    'adenta': 'Greater Accra',
    'ashaiman': 'Greater Accra',
    'teshie': 'Greater Accra',
    'obuasi': 'Ashanti',
    'ejisu': 'Ashanti',
    'mampong': 'Ashanti',
    'takoradi': 'Western',
    'tarkwa': 'Western',
    'winneba': 'Central',
    'kasoa': 'Central',
    'elmina': 'Central',
    'nkawkaw': 'Eastern',
    'akosombo': 'Eastern',
    'aburi': 'Eastern',
    'yendi': 'Northern',
    'hohoe': 'Volta',
    'keta': 'Volta',
    'aflao': 'Volta',
    'berekum': 'Bono',
    'dormaa ahenkro': 'Bono',
  };

  /// Ghana mobile prefixes, by network. Used to validate a phone number rather
  /// than accepting anything that looks vaguely numeric.
  static const mobilePrefixes = <String>[
    '20', '23', '24', '25', '26', '27', '28', '29',
    '50', '53', '54', '55', '56', '57', '59',
  ];

  /// Normalises a Ghanaian phone number to `+233 XX XXX XXXX`.
  ///
  /// Accepts the forms people actually type: `0241234567`, `241234567`,
  /// `+233241234567`, and any of those with spaces or dashes. Returns the input
  /// unchanged when it does not look like a Ghanaian mobile number, so a
  /// landline or foreign number is not silently mangled.
  static String formatPhone(String input) {
    var digits = input.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('+233')) {
      digits = digits.substring(4);
    } else if (digits.startsWith('233')) {
      digits = digits.substring(3);
    } else if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    digits = digits.replaceAll('+', '');

    if (digits.length != 9) return input.trim();
    if (!mobilePrefixes.contains(digits.substring(0, 2))) return input.trim();

    return '+233 ${digits.substring(0, 2)} ${digits.substring(2, 5)}'
        ' ${digits.substring(5)}';
  }

  /// Validation message for a phone field, or null when acceptable.
  ///
  /// Blank is allowed — not every member has a phone, and refusing to save a
  /// record over a missing number would be worse than storing it without one.
  static String? validatePhone(String? input) {
    final value = (input ?? '').trim();
    if (value.isEmpty) return null;

    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length < 9) return 'That looks too short for a phone number';

    final normalised = formatPhone(value);
    if (!normalised.startsWith('+233')) {
      // Kept, but flagged: it may be a landline or a number from abroad.
      return null;
    }
    return null;
  }
}

class GhanaRegion {
  const GhanaRegion(this.name, this.capital);

  final String name;

  /// The regional capital, used to infer a region from a typed city.
  final String capital;
}
