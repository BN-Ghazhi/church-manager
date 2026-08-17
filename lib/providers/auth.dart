import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../db/database.dart';
import '../db/repository.dart';
import '../models/models.dart';

/// The live database, opened once for the life of the app.
///
/// Overridden in `main()` with the instance created at startup, and in tests
/// with an in-memory database.
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

final repositoryProvider = Provider<ChurchRepository>(
  (ref) => ChurchRepository(ref.watch(databaseProvider)),
);

/// Result of a sign-in attempt, so the form can say what went wrong without
/// the caller having to interpret a null.
sealed class SignInResult {
  const SignInResult();
}

class SignInSuccess extends SignInResult {
  const SignInSuccess(this.user);
  final StaffUser user;
}

class SignInFailure extends SignInResult {
  const SignInFailure(this.message);
  final String message;
}

/// The authenticated session.
///
/// Null means signed out, which is what the router keys off to show the sign-in
/// screen. The session lives in memory only — closing the app signs you out,
/// which is the right default for a shared church-office machine.
final sessionProvider =
    NotifierProvider<SessionNotifier, StaffUser?>(SessionNotifier.new);

class SessionNotifier extends Notifier<StaffUser?> {
  @override
  StaffUser? build() => null;

  Future<SignInResult> signIn(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      return const SignInFailure('Enter your email and password.');
    }

    final user = await ref.read(repositoryProvider).signIn(email, password);

    if (user == null) {
      // Deliberately identical for unknown email, wrong password and suspended
      // account — a different message for each would let someone enumerate
      // valid addresses.
      return const SignInFailure(
        'Those details did not match an active account.',
      );
    }

    state = user;
    return SignInSuccess(user);
  }

  void signOut() => state = null;

  /// Refreshes the session after the signed-in user's own record changes.
  void refresh(StaffUser user) => state = user;
}

/// True once a user is signed in. The router redirects on this.
final isSignedInProvider = Provider<bool>((ref) => ref.watch(sessionProvider) != null);
