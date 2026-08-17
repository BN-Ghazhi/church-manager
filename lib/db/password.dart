import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';

/// Password hashing for local sign-in.
///
/// PBKDF2-HMAC-SHA256 with a per-user random salt. Passwords are never stored
/// or logged in plain text, and verification is constant-time so a wrong
/// password cannot be narrowed down by timing.
///
/// **Scope of this protection.** The database file sits on the user's own disk
/// and is not encrypted, so anyone with access to the machine can read the
/// tables. Hashing means a stolen database still does not hand over passwords —
/// which matters because people reuse them. It is not a substitute for disk
/// encryption or for server-side auth once this app talks to a backend.
class Password {
  const Password._();

  /// Deliberately slow: the cost is what makes a leaked hash expensive to
  /// brute-force. Pure-Dart PBKDF2 is not fast, so this is tuned to keep a
  /// single sign-in well under a second rather than chasing a round number.
  static const productionIterations = 20000;

  /// Lowered in tests only. Seeding creates ~50 accounts at once and the full
  /// cost would add minutes to the suite without testing anything extra.
  static int _iterations = productionIterations;

  /// Test-only hook. Never call this from application code.
  @visibleForTesting
  static void useFastHashingForTests({int iterations = 500}) {
    _iterations = iterations;
  }

  static const _keyLength = 32;

  static final _random = Random.secure();

  static String generateSalt() {
    final bytes = Uint8List.fromList(
      List.generate(16, (_) => _random.nextInt(256)),
    );
    return base64Encode(bytes);
  }

  /// Derives the stored hash for [password] under [salt].
  static String hash(String password, String salt) {
    final saltBytes = base64Decode(salt);
    final passwordBytes = utf8.encode(password);

    // PBKDF2: repeatedly HMAC the previous block, XOR-accumulating the result.
    final hmac = Hmac(sha256, passwordBytes);
    final output = Uint8List(_keyLength);
    var offset = 0;
    var blockIndex = 1;

    while (offset < _keyLength) {
      final block = _deriveBlock(hmac, saltBytes, blockIndex);
      final take = min(block.length, _keyLength - offset);
      output.setRange(offset, offset + take, block);
      offset += take;
      blockIndex++;
    }

    return base64Encode(output);
  }

  static Uint8List _deriveBlock(Hmac hmac, List<int> salt, int blockIndex) {
    final indexBytes = Uint8List(4)
      ..[0] = (blockIndex >> 24) & 0xff
      ..[1] = (blockIndex >> 16) & 0xff
      ..[2] = (blockIndex >> 8) & 0xff
      ..[3] = blockIndex & 0xff;

    var current = Uint8List.fromList(
      hmac.convert([...salt, ...indexBytes]).bytes,
    );
    final result = Uint8List.fromList(current);

    for (var i = 1; i < _iterations; i++) {
      current = Uint8List.fromList(hmac.convert(current).bytes);
      for (var j = 0; j < result.length; j++) {
        result[j] ^= current[j];
      }
    }
    return result;
  }

  /// True when [password] matches the stored hash.
  ///
  /// Compares every byte regardless of where the first mismatch is, so the time
  /// taken reveals nothing about how close a guess was.
  static bool verify(String password, String salt, String expectedHash) {
    final actual = utf8.encode(hash(password, salt));
    final expected = utf8.encode(expectedHash);
    if (actual.length != expected.length) return false;

    var diff = 0;
    for (var i = 0; i < actual.length; i++) {
      diff |= actual[i] ^ expected[i];
    }
    return diff == 0;
  }

  /// Rejects passwords that are trivially guessable. Returns null when valid.
  static String? validate(String password) {
    if (password.length < 8) return 'Use at least 8 characters.';
    if (!password.contains(RegExp(r'[A-Za-z]'))) {
      return 'Include at least one letter.';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Include at least one number.';
    }
    const common = {
      'password', 'password1', '12345678', 'qwerty123', 'church123',
      'letmein1', 'welcome1', 'abc12345',
    };
    if (common.contains(password.toLowerCase())) {
      return 'That password is too common — pick something else.';
    }
    return null;
  }
}
