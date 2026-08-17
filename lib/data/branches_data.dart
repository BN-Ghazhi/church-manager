import '../models/models.dart';
import 'seed.dart';

/// The church's campuses.
///
/// Headquarters is itself a branch (flagged [Branch.isHeadquarters]) so every
/// query can treat branches uniformly instead of special-casing HQ. Pastor ids
/// are filled in by `members_data.dart` once members exist — see [branches].
class BranchSeed {
  const BranchSeed(this.code, this.name, this.city, this.state, this.line1,
      this.status, this.year, this.accent, this.isHq);

  final String code;
  final String name;
  final String city;
  final String state;
  final String line1;
  final BranchStatus status;
  final int year;
  final AccentToken accent;
  final bool isHq;
}

const branchSeeds = <BranchSeed>[
  BranchSeed('HQ', 'Grace Chapel Headquarters', 'Accra', 'Greater Accra',
      '14 Ring Road Central, Adabraka', BranchStatus.active, 2004,
      AccentToken.blue, true),
  BranchSeed('TEM', 'Grace Chapel Tema', 'Tema', 'Greater Accra',
      '7 Community 5 Main Road', BranchStatus.active, 2011,
      AccentToken.emerald, false),
  BranchSeed('KUM', 'Grace Chapel Kumasi', 'Kumasi', 'Ashanti',
      '22 Harper Road, Adum', BranchStatus.active, 2015,
      AccentToken.violet, false),
  BranchSeed('TAK', 'Grace Chapel Takoradi', 'Takoradi', 'Western',
      '5 Liberation Road, Market Circle', BranchStatus.active, 2018,
      AccentToken.amber, false),
  BranchSeed('TAM', 'Grace Chapel Tamale', 'Tamale', 'Northern',
      '18 Bolgatanga Road', BranchStatus.active, 2021,
      AccentToken.cyan, false),
  BranchSeed('CCO', 'Grace Chapel Cape Coast', 'Cape Coast', 'Central',
      '9 Commercial Street', BranchStatus.planting, 2025,
      AccentToken.rose, false),
];

/// Branch ids are stable and derived from the seed order.
String branchIdAt(int index) => Seed.id('brn', index);

/// The headquarters id, used as the default scope and for church-wide records.
final String hqBranchId = branchIdAt(0);

/// Every branch id, in display order (HQ first).
final List<String> branchIds =
    List.generate(branchSeeds.length, branchIdAt);

/// Deterministically assigns a member index to a branch.
///
/// HQ is weighted heaviest and the church plant lightest, so branch sizes look
/// like a real church rather than an even split.
String branchForMemberIndex(int i) {
  const weights = [0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3, 4, 5];
  return branchIdAt(weights[i % weights.length]);
}
