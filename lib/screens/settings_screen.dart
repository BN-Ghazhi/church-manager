import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../config/app_config.dart';
import '../config/ghana.dart';
import '../providers/auth.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../widgets/feedback.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';

const _integrations = [
  ('Paystack', 'Online giving and card payments', true),
  ('Twilio', 'SMS delivery to members', true),
  ('Mailgun', 'Transactional and bulk email', true),
  ('Zoom', 'Online services and midweek meetings', false),
  ('Google Calendar', 'Two-way event synchronisation', false),
  ('QuickBooks', 'Accounting and bookkeeping export', false),
];

class _Preference {
  const _Preference(this.id, this.label, this.description, this.defaultOn);

  final String id;
  final String label;
  final String description;
  final bool defaultOn;
}

const _preferences = [
  _Preference('first-timer', 'Automatic first-timer follow-up',
      "Send a welcome message the day after a visitor's first service.", true),
  _Preference('birthday', 'Birthday greetings',
      'Send members a greeting on their birthday at 7:00 AM.', true),
  _Preference('inactive', 'Flag inactive members',
      'Mark members inactive after 90 days without attendance.', true),
  _Preference('receipts', 'Instant giving receipts',
      'Email a receipt as soon as a donation is recorded.', true),
  _Preference('rota', 'Serving rota reminders',
      'Remind volunteers two days before they serve.', true),
  _Preference('hide-giving', 'Hide giving from ministry leaders',
      'Only finance and admin roles can see contribution amounts.', true),
  _Preference('directory', 'Member-visible directory',
      'Let members look each other up in the self-service portal.', false),
  _Preference('digest', 'Weekly leadership digest',
      'Email a summary of attendance, giving and care every Monday.', false),
];

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  /// Church-profile fields, created lazily from whatever is stored.
  final _controllers = <String, TextEditingController>{};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(themeModeProvider);
    final stored = ref.watch(settingsStreamProvider).valueOrNull ?? const {};

    return PageBody(
      children: [
        PageHeader(
          title: 'Settings',
          description:
              'Church profile, service schedule, integrations and system preferences.',
          actions: [
            FilledButton.icon(
              onPressed: () async {
                await ref.read(repositoryProvider).saveSettings({
                  for (final entry in _controllers.entries)
                    entry.key: entry.value.text.trim(),
                });
                if (!context.mounted) return;
                showLocalSuccess(context, 'Church details saved.');
              },
              icon: const Icon(Icons.save_outlined, size: 17),
              label: const Text('Save changes'),
            ),
          ],
        ),
        SectionCard(
          title: 'Church details',
          description:
              'Appears on statements, receipts and outgoing messages.',
          child: ResponsiveGrid(
            minItemWidth: 260,
            maxColumns: 2,
            children: [
              _field('Church name', 'church.name', stored, ChurchConfig.name),
              _field('Legal name', 'church.legalName', stored,
                  ChurchConfig.legalName),
              _field('Lead pastor', 'church.pastor', stored,
                  ChurchConfig.pastor),
              _field('Year founded', 'church.founded', stored,
                  ChurchConfig.founded),
              _field('Email', 'church.email', stored, ChurchConfig.email),
              _field('Phone', 'church.phone', stored, ChurchConfig.phone),
              _field('Website', 'church.website', stored,
                  ChurchConfig.website),
              _field('Address', 'church.address', stored,
                  ChurchConfig.addressLine),
              _field('City or town', 'church.city', stored, ChurchConfig.city),
              _regionField('church.state', stored),
              _field('Country', 'church.country', stored, Ghana.country),
              _field('Currency', 'church.currency', stored,
                  ChurchConfig.currency),
              _field('Timezone', 'church.timezone', stored,
                  ChurchConfig.timezone),
            ],
          ),
        ),
        SplitRow(
          primaryFlex: 1,
          secondaryFlex: 1,
          primary: SectionCard(
            title: 'Weekly service schedule',
            description:
                'Recurring services that generate attendance records.',
            child: Column(
              children: [
                for (final s in ChurchConfig.services)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.church_outlined,
                        size: 18,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    title: Text(s.name,
                        style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text(s.venue,
                        style: Theme.of(context).textTheme.labelSmall),
                    trailing: Text('${s.day} · ${s.time}',
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
              ],
            ),
          ),
          secondary: SectionCard(
            title: 'Appearance',
            description: 'How the console looks on this device.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                        value: ThemeMode.light,
                        label: Text('Light'),
                        icon: Icon(Icons.light_mode_outlined, size: 16)),
                    ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text('Dark'),
                        icon: Icon(Icons.dark_mode_outlined, size: 16)),
                    ButtonSegment(
                        value: ThemeMode.system,
                        label: Text('System'),
                        icon: Icon(Icons.computer_outlined, size: 16)),
                  ],
                  selected: {mode},
                  showSelectedIcon: false,
                  onSelectionChanged: (s) =>
                      ref.read(themeModeProvider.notifier).set(s.first),
                ),
                const SizedBox(height: AppSpacing.sm + 4),
                Text(
                  'Theme is remembered for this session; it will persist once settings are stored.',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
        SectionCard(
          title: 'System preferences',
          description: 'Notifications, automation and privacy defaults.',
          child: Column(
            children: [
              for (final p in _preferences)
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: (stored['pref.${p.id}'] ?? '${p.defaultOn}') == 'true',
                  onChanged: (v) async {
                    await ref
                        .read(repositoryProvider)
                        .saveSetting('pref.${p.id}', '$v');
                    if (!context.mounted) return;
                    showLocalSuccess(
                      context,
                      '${p.label} ${v ? 'enabled' : 'disabled'}.',
                    );
                  },
                  title: Text(p.label,
                      style: Theme.of(context).textTheme.bodyMedium),
                  subtitle: Text(p.description,
                      style: Theme.of(context).textTheme.labelSmall),
                ),
            ],
          ),
        ),
        SectionCard(
          title: 'Connected services',
          description: 'Payments, messaging and calendar providers.',
          child: ResponsiveGrid(
            minItemWidth: 300,
            maxColumns: 3,
            children: [
              for (final (name, purpose, connected) in _integrations)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm + 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withValues(alpha: 0.7),
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.extension_outlined,
                          size: 18,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      const SizedBox(width: AppSpacing.sm + 2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            Text(purpose,
                                style:
                                    Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ),
                      Chip(
                        label: Text(connected ? 'Connected' : 'Available'),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: connected
                            ? AppTheme.success.withValues(alpha: 0.12)
                            : Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: connected
                                  ? AppTheme.success
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SectionCard(
          title: 'Data',
          description:
              'This app stores everything in its own database on this computer. '
              'No server is involved and it works offline.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.storage_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.sm + 2),
                  Expanded(
                    child: Text(
                      'Everything you add or edit is saved immediately and is '
                      'still there when you reopen the app.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: () => _confirmReset(context, ref),
                icon: const Icon(Icons.restart_alt, size: 17),
                label: const Text('Reset to demo data'),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Deletes everything and restores the original sample data. '
                'This cannot be undone.',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: Text(
            '${AppInfo.name} v${AppInfo.version}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }

  /// Resetting destroys real data, so it asks first and names the consequence
  /// plainly rather than relying on the button label alone.
  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to demo data?'),
        content: const Text(
          'This permanently deletes every member, department, donation and '
          'record you have entered, and restores the original sample data. '
          'It cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.danger,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete and reset'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await ref.read(databaseProvider).resetToSeed();
    if (!context.mounted) return;
    showLocalSuccess(context, 'Database reset to the original sample data.');
  }

  /// A church-profile field bound to a settings key.
  ///
  /// The controller is created once and reused, so typing is not interrupted
  /// each time the settings stream re-emits.
  /// Region as a picker rather than free text — Ghana has sixteen named
  /// regions, and typing them produces inconsistent spellings.
  Widget _regionField(String key, Map<String, String> stored) {
    final controller = _controllers.putIfAbsent(
      key,
      () => TextEditingController(text: stored[key] ?? ''),
    );
    final current = controller.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(Ghana.regionLabel,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: current.isEmpty ? null : current,
          isExpanded: true,
          hint: const Text('Choose a region'),
          items: [
            for (final region in <String>{...Ghana.regionNames, if (current.isNotEmpty) current}.toList()..sort())
              DropdownMenuItem(value: region, child: Text(region)),
          ],
          onChanged: (value) => setState(() => controller.text = value ?? ''),
        ),
      ],
    );
  }

  Widget _field(
    String label,
    String key,
    Map<String, String> stored,
    String fallback,
  ) {
    final controller = _controllers.putIfAbsent(
      key,
      () => TextEditingController(text: stored[key] ?? fallback),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(controller: controller),
      ],
    );
  }
}
