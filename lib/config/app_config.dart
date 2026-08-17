/// Church-wide configuration.
///
/// Everything here is tenant-specific and will move to the organisation record
/// in the database. Until then it is the one place to change branding, service
/// times and the signed-in user used by the UI.
class ChurchConfig {
  const ChurchConfig._();

  static const name = 'Grace Chapel';
  static const tagline = 'Management Console';
  static const legalName = 'Grace Chapel International Ministries';
  static const email = 'office@gracechapel.org';
  static const phone = '+233 24 123 4567';
  static const website = 'gracechapel.org';
  static const addressLine = '14 Ring Road Central, Adabraka';
  static const city = 'Accra';
  static const state = 'Greater Accra';
  static const country = 'Ghana';
  static const pastor = 'Pastor Samuel Mensah';
  static const founded = '2004';
  static const currency = 'GHS';
  static const timezone = 'Africa/Accra';

  /// Stand-in for the authenticated session until auth is wired up.
  static const currentUserName = 'Grace Ansah';
  static const currentUserInitials = 'GA';
  static const currentUserEmail = 'ansah@gracechapel.org';
  static const currentUserRole = 'Administrator';

  static const services = <ServiceSlot>[
    ServiceSlot('First Service', 'Sunday', '7:00 AM', 'Main Auditorium'),
    ServiceSlot('Second Service', 'Sunday', '10:00 AM', 'Main Auditorium'),
    ServiceSlot('Bible Study', 'Wednesday', '6:00 PM', 'Main Auditorium'),
    ServiceSlot('Prayer Meeting', 'Tuesday', '5:00 AM', 'Prayer Chapel'),
  ];
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
