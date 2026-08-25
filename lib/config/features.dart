/// Modules switched off for now.
///
/// The church asked for giving, communication and volunteers to be hidden
/// everywhere until they are ready to use them. They are hidden rather than
/// deleted: the screens, tables and tests all still work, so turning one back on
/// is removing a line from this set — not rebuilding a feature.
///
/// Names match the `module` strings in `permissions.dart`, which is what the
/// sidebar, the permission matrix and the dashboard all key off.
class Features {
  const Features._();

  static const hiddenModules = <String>{
    'Giving & Finance',
    'Communication',
    'Volunteers',
    'Pastoral Care',
    'Assets',
  };

  static bool isHidden(String module) => hiddenModules.contains(module);

  /// Multi-branch is switched off for now: one church, one branch.
  ///
  /// The Branches screen stays visible so the structure is discoverable — a
  /// church that grows will look for it — but nothing on it can be changed, and
  /// the branch switcher is hidden because there is only ever one branch to
  /// choose. Everything files against that branch automatically.
  ///
  /// The multi-branch code is untouched. Setting this to true restores adding,
  /// editing and switching; no data model changes are involved, because a
  /// single-branch church is just the multi-branch case with one row.
  static const multiBranchEnabled = false;

  /// Routes that belong to hidden modules, for guarding direct navigation.
  static const hiddenRoutes = <String>{
    '/finance',
    '/communication',
    '/volunteers',
    '/care',
    '/assets',
  };
}
