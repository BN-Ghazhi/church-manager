/// The application's notion of "now".
///
/// Ages, relative times and "this month" totals all need a reference point.
/// This used to be a fixed date belonging to the bundled demo dataset; with real
/// records it must be the actual current time, or a member's age and every
/// "3 days ago" would be wrong.
///
/// Routed through one function so tests can reason about it, and so there is a
/// single place to change if the app ever needs a church-local timezone rather
/// than UTC.
DateTime appNow() => DateTime.now().toUtc();
