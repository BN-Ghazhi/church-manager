import 'dart:math';

/// Generates record ids that are unique across machines.
///
/// The previous scheme read the highest existing id and added one. That is
/// correct on a single machine and silently wrong the moment there are two: both
/// laptops, working offline, produce `mem-0001`, and whichever syncs second
/// overwrites the first — a member vanishing from the register with no error
/// anywhere. It also broke at ten thousand rows, because `mem-10000` sorts below
/// `mem-9999` as text, so the counter quietly restarted.
///
/// The replacement is a ULID: 48 bits of millisecond timestamp followed by 80
/// bits of randomness, in Crockford base32. Two properties matter here.
///
/// **Unique without coordination.** 80 random bits means two machines creating a
/// record in the same millisecond will not collide in any realistic lifetime of
/// this app, so no server round-trip is needed to mint an id. That is what makes
/// offline writes possible.
///
/// **Still sorted by time.** The timestamp leads, so ids sort chronologically as
/// text — exactly the property the old zero-padded counter had, and which
/// `ORDER BY id` in several queries relies on. A plain UUIDv4 would have lost it.
///
/// The readable prefix stays (`mem-`, `brn-`), so a glance at a row still says
/// what it is, and the ids seeded by `Seeder` (`dpt-youth`, `brn-0001`) remain
/// valid — they are written literally and never parsed.
class Ids {
  const Ids._();

  /// Crockford base32: no I, L, O or U, so ids cannot be misread aloud or
  /// mistyped into a support conversation.
  static const _alphabet = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';

  static final _random = Random.secure();

  /// A new id for [prefix], e.g. `Ids.next('mem')`.
  static String next(String prefix) => '$prefix-${_ulid()}';

  /// 26 characters: 10 of timestamp, 16 of randomness.
  static String _ulid() {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final buffer = StringBuffer();

    // 48-bit timestamp, most significant character first, so lexical order
    // matches chronological order.
    for (var i = 9; i >= 0; i--) {
      buffer.write(_alphabet[(now >> (i * 5)) & 0x1f]);
    }

    // 80 bits of randomness. Drawn from Random.secure() rather than Random(),
    // because a predictable id is a way to guess at records you were not shown.
    for (var i = 0; i < 16; i++) {
      buffer.write(_alphabet[_random.nextInt(32)]);
    }

    return buffer.toString();
  }
}
