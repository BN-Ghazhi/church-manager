import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../db/password.dart';
import '../db/seeder.dart';
import '../providers/auth.dart';
import '../theme/app_theme.dart';

/// First-run setup: the church, and the account that will run it.
///
/// This replaced a published `admin` / `church2026` login. Shipping credentials
/// means every copy of the app has the same ones until somebody remembers to
/// change them, and the README telling them to is not a control. Here the first
/// password is chosen by the person installing it, so there is nothing to leak.
///
/// Two steps rather than one long form: the church and the administrator are
/// different subjects, and a single screen of nine fields reads as a chore on
/// what should be a welcoming first impression.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _churchKey = GlobalKey<FormState>();
  final _adminKey = GlobalKey<FormState>();

  final _church = TextEditingController();
  final _short = TextEditingController();
  final _branch = TextEditingController();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  int _step = 0;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Typing the church name fills the two fields derived from it, which the
    // user can still overwrite. Most churches would type the same thing twice.
    _church.addListener(_deriveFromChurchName);
  }

  void _deriveFromChurchName() {
    final name = _church.text.trim();
    if (name.isEmpty) return;

    if (!_shortEdited) {
      final initials = name
          .split(RegExp(r'\s+'))
          .where((w) => w.length > 2)
          .map((w) => w[0].toUpperCase())
          .join('.');
      _short.text = initials.isEmpty ? '' : '$initials.';
    }
    if (!_branchEdited) {
      _branch.text = '$name Headquarters';
    }
  }

  bool _shortEdited = false;
  bool _branchEdited = false;

  @override
  void dispose() {
    _church.removeListener(_deriveFromChurchName);
    for (final c in [
      _church,
      _short,
      _branch,
      _name,
      _username,
      _password,
      _confirm,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _finish() async {
    if (!_adminKey.currentState!.validate()) return;

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      final db = ref.read(databaseProvider);
      await Seeder(db).completeOnboarding(
        churchName: _church.text.trim(),
        shortName: _short.text.trim(),
        branchName: _branch.text.trim(),
        adminName: _name.text.trim(),
        adminUsername: _username.text.trim(),
        adminPassword: _password.text,
      );

      // Sign the new administrator straight in: making them retype credentials
      // they set thirty seconds ago is friction for its own sake.
      final result = await ref.read(sessionProvider.notifier).signIn(
            _username.text.trim(),
            _password.text,
          );
      if (result is SignInSuccess) return;

      // Setup succeeded but sign-in did not, which should not happen — say so
      // rather than leaving a blank screen.
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Setup finished, but signing in failed. Try signing in with '
            'the username and password you just set.';
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = '$error'.replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child:
                        Icon(Icons.church, size: 28, color: scheme.onPrimary),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  _step == 0
                      ? "Let's set up your church. This takes a minute, and only "
                          'happens once.'
                      : 'Now the account you will use to sign in.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.lg),
                _StepDots(step: _step, count: 2),
                const SizedBox(height: AppSpacing.lg),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: _step == 0 ? _churchStep() : _adminStep(),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm + 4),
                    decoration: BoxDecoration(
                      color: AppTheme.danger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                          color: AppTheme.danger.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline,
                            size: 17, color: AppTheme.danger),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(_error!,
                              style: theme.textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _churchStep() => Form(
        key: _churchKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(
              label: 'Church name',
              controller: _church,
              hint: 'Kingdom Grace Chapel',
              autofocus: true,
              validator: (v) => (v ?? '').trim().isEmpty
                  ? "Your church's name is required"
                  : null,
            ),
            _field(
              label: 'Short name',
              controller: _short,
              hint: 'K.G.C.',
              helper: 'Used where space is tight. Filled in from the name above.',
              onChanged: (_) => _shortEdited = true,
            ),
            _field(
              label: 'First branch',
              controller: _branch,
              hint: 'Kingdom Grace Chapel Headquarters',
              helper: 'Members, services and giving are filed against this. You '
                  'can rename it later.',
              onChanged: (_) => _branchEdited = true,
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? 'A branch name is required' : null,
            ),
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () {
                  if (!_churchKey.currentState!.validate()) return;
                  setState(() => _step = 1);
                },
                icon: const Icon(Icons.arrow_forward, size: 17),
                label: const Text('Continue'),
              ),
            ),
          ],
        ),
      );

  Widget _adminStep() => Form(
        key: _adminKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(
              label: 'Your name',
              controller: _name,
              hint: 'Grace Ansah',
              autofocus: true,
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? 'Your name is required' : null,
            ),
            _field(
              label: 'Username',
              controller: _username,
              hint: 'grace',
              helper: 'What you type to sign in. Not an email address.',
              validator: (v) {
                final value = (v ?? '').trim();
                if (value.isEmpty) return 'A username is required';
                if (value.length < 3) return 'At least three characters';
                if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
                  return 'Letters, numbers, dots, dashes and underscores only';
                }
                return null;
              },
            ),
            _field(
              label: 'Password',
              controller: _password,
              obscure: true,
              helper: 'At least 8 characters, with a letter and a number.',
              validator: (v) => Password.validate(v ?? ''),
            ),
            _field(
              label: 'Confirm password',
              controller: _confirm,
              obscure: true,
              // Typed twice because it is obscured, and this is the only account
              // that exists — a typo here locks the church out of its own app.
              validator: (v) =>
                  v == _password.text ? null : 'The two passwords do not match',
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                TextButton.icon(
                  onPressed: _busy ? null : () => setState(() => _step = 0),
                  icon: const Icon(Icons.arrow_back, size: 17),
                  label: const Text('Back'),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: _busy ? null : _finish,
                  icon: _busy
                      ? const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check, size: 17),
                  label: Text(_busy ? 'Setting up…' : 'Finish setup'),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _field({
    required String label,
    required TextEditingController controller,
    String? hint,
    String? helper,
    bool obscure = false,
    bool autofocus = false,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: controller,
              obscureText: obscure,
              autofocus: autofocus,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hint,
                helperText: helper,
                helperMaxLines: 2,
              ),
              validator: validator,
            ),
          ],
        ),
      );
}

/// Progress dots, so it is clear the setup is short.
class _StepDots extends StatelessWidget {
  const _StepDots({required this.step, required this.count});

  final int step;
  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Container(
            width: i == step ? 22 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: i <= step
                  ? scheme.primary
                  : scheme.outlineVariant.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
