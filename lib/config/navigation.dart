import 'package:flutter/material.dart';

/// A single destination in the app's information architecture.
class NavItem {
  const NavItem({
    required this.title,
    required this.route,
    required this.icon,
    required this.selectedIcon,
    required this.description,
    required this.module,
    this.badge,
  });

  final String title;
  final String route;
  final IconData icon;
  final IconData selectedIcon;

  /// Used by the command palette and as the page subtitle.
  final String description;

  /// The permission module this screen belongs to. The sidebar hides any
  /// destination the signed-in role cannot read, so navigation always reflects
  /// actual access rather than listing dead ends.
  final String module;
  final String? badge;
}

class NavSection {
  const NavSection({required this.label, required this.items});

  final String label;
  final List<NavItem> items;
}

/// The app's information architecture — the single source for the sidebar, the
/// rail, the mobile drawer and the search palette. Add a screen here and it
/// appears in all of them.
const List<NavSection> navigation = [
  NavSection(label: 'Overview', items: [
    NavItem(
      title: 'Dashboard',
      route: '/dashboard',
      module: 'Members',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      description:
          'Church health at a glance, with reports on the second tab.',
    ),
  ]),
  NavSection(label: 'Church', items: [
    NavItem(
      title: 'Branches',
      route: '/branches',
      module: 'Branches',
      icon: Icons.account_tree_outlined,
      selectedIcon: Icons.account_tree,
      description: 'Every campus, its pastor, departments and health.',
    ),
  ]),
  NavSection(label: 'People', items: [
    NavItem(
      title: 'Members',
      route: '/members',
      module: 'Members',
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
      description: 'The member directory — profiles, families and follow-up.',
    ),
    NavItem(
      title: 'Attendance',
      route: '/attendance',
      module: 'Attendance',
      icon: Icons.how_to_reg_outlined,
      selectedIcon: Icons.how_to_reg,
      description: 'Service check-in, headcounts and attendance trends.',
    ),
    NavItem(
      title: 'Departments',
      route: '/departments',
      module: 'Departments',
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups,
      description: 'Youth, children and every other department, per branch.',
    ),
    NavItem(
      title: 'Groups & Ministries',
      route: '/ministries',
      module: 'Departments',
      icon: Icons.hub_outlined,
      selectedIcon: Icons.hub,
      description: 'Departments, home cells and their leaders.',
    ),
    NavItem(
      title: 'Pastoral Care',
      route: '/care',
      module: 'Pastoral Care',
      icon: Icons.volunteer_activism_outlined,
      selectedIcon: Icons.volunteer_activism,
      description: 'Prayer requests, counselling and visitation tracking.',
      badge: '6',
    ),
    NavItem(
      title: 'Discipleship',
      route: '/discipleship',
      module: 'Discipleship',
      icon: Icons.school_outlined,
      selectedIcon: Icons.school,
      description: 'Courses, classes and spiritual growth pathways.',
    ),
  ]),
  NavSection(label: 'Operations', items: [
    NavItem(
      title: 'Events',
      route: '/events',
      module: 'Events',
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
      description: 'Church calendar, registrations and recurring services.',
    ),
    NavItem(
      title: 'Volunteers',
      route: '/volunteers',
      module: 'Volunteers',
      icon: Icons.assignment_outlined,
      selectedIcon: Icons.assignment,
      description: 'Serving rotas, role assignments and availability.',
    ),
    NavItem(
      title: 'Giving & Finance',
      route: '/finance',
      module: 'Giving & Finance',
      icon: Icons.payments_outlined,
      selectedIcon: Icons.payments,
      description: 'Donations, pledges, expenses and financial reporting.',
    ),
    NavItem(
      title: 'Communication',
      route: '/communication',
      module: 'Communication',
      icon: Icons.campaign_outlined,
      selectedIcon: Icons.campaign,
      description: 'Email, SMS and push campaigns to any audience.',
    ),
    NavItem(
      title: 'Assets',
      route: '/assets',
      module: 'Assets',
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
      description: 'Equipment register, condition and maintenance history.',
    ),
  ]),
  NavSection(label: 'Administration', items: [
    NavItem(
      title: 'Roles & Access',
      route: '/access',
      module: 'Roles & Access',
      icon: Icons.verified_user_outlined,
      selectedIcon: Icons.verified_user,
      description: 'Users, roles and the module permission matrix.',
    ),
    NavItem(
      title: 'Settings',
      route: '/settings',
      module: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      description: 'Church profile, branding, services and integrations.',
    ),
  ]),
];

/// Flat list of every destination, for lookups and search.
final List<NavItem> navItems = [
  for (final section in navigation) ...section.items,
];

/// The destination whose route best matches [location].
NavItem? findNavItem(String location) {
  final matches = navItems
      .where((i) => location == i.route || location.startsWith('${i.route}/'))
      .toList()
    ..sort((a, b) => b.route.length.compareTo(a.route.length));
  return matches.isEmpty ? null : matches.first;
}

String? sectionOf(String route) {
  for (final section in navigation) {
    if (section.items.any((i) => i.route == route)) return section.label;
  }
  return null;
}
