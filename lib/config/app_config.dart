/// Church-wide configuration.
///
/// Everything here is tenant-specific and will move to the organisation record
/// in the database. Until then it is the one place to change branding, service
/// times and the signed-in user used by the UI.
class ChurchConfig {
  const ChurchConfig._();

  static const name = 'Kingdom Grace Chapel';
  static const shortName = 'K.G.C.';
  static const tagline = 'Management Console';
  static const legalName = 'Kingdom Grace Chapel';
  static const email = '';
  static const phone = '';
  static const website = '';
  static const addressLine = '';
  static const city = '';
  static const state = '';
  static const country = 'Ghana';
  static const pastor = '';
  static const founded = '';
  static const currency = 'GHS';
  static const timezone = 'Africa/Accra';

  /// Stand-in for the authenticated session until auth is wired up.
  static const currentUserName = 'Administrator';
  static const currentUserInitials = 'A';
  static const currentUserEmail = 'admin@kgc.org';
  static const currentUserRole = 'Administrator';

  /// Standing weekly services. Empty until the church adds its own in
  /// Settings — inventing a schedule would only have to be deleted.
  static const services = <ServiceSlot>[];
}

class ServiceSlot {
  const ServiceSlot(this.name, this.day, this.time, this.venue);

  final String name;
  final String day;
  final String time;
  final String venue;
}

class AppInfo {
  const AppInfo._();

  static const name = 'Church Management System';
  static const shortName = 'ChurchMS';
  static const version = '0.1.0';
  static const description =
      'A complete church management console — members, attendance, giving, '
      'events, volunteers, pastoral care and communication in one place.';
}
