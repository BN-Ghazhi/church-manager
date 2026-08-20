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
  };

  static bool isHidden(String module) => hiddenModules.contains(module);

  /// Routes that belong to hidden modules, for guarding direct navigation.
  static const hiddenRoutes = <String>{
    '/finance',
    '/communication',
    '/volunteers',
  };
}
