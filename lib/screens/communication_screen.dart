import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../utils/clock.dart';
import '../models/models.dart';
import '../providers/repository.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/compose_form.dart';
import '../widgets/page_header.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

IconData _channelIcon(CampaignChannel channel) => switch (channel) {
      CampaignChannel.email => Icons.mail_outline,
      CampaignChannel.sms => Icons.sms_outlined,
      CampaignChannel.push => Icons.notifications_active_outlined,
      CampaignChannel.whatsapp => Icons.chat_outlined,
    };

class CommunicationScreen extends ConsumerWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaigns = ref.watch(campaignsProvider);
    final sent = campaigns.where((c) => c.status == CampaignStatus.sent).toList();
    final scheduled =
        campaigns.where((c) => c.status == CampaignStatus.scheduled).length;
    final reached = sent.fold(0, (s, c) => s + c.recipients);
    final avgOpen = sent.isEmpty
        ? 0
        : sent.fold(0, (s, c) => s + (c.openRate ?? 0)) ~/ sent.length;

    final byChannel = <CampaignChannel, int>{};
    for (final c in campaigns) {
      byChannel[c.channel] = (byChannel[c.channel] ?? 0) + c.recipients;
    }
    final channelData = byChannel.entries
        .map((e) => CategoryPoint(label: e.key.label, value: e.value.toDouble()))
        .toList();

    return PageBody(
      children: [
        PageHeader(
          title: 'Communication',
          description:
              'Reach the congregation by email, SMS, WhatsApp or push — and see what landed.',
          actions: [
            FilledButton.icon(
              onPressed: () => showComposeForm(context),
              icon: const Icon(Icons.send_outlined, size: 17),
              label: const Text('Compose message'),
            ),
          ],
        ),
        ResponsiveGrid(
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Messages sent',
              value: '${sent.length}',
              hint: 'in the last 7 days',
              icon: Icons.send_outlined,
            ),
            StatCard(
              label: 'People reached',
              value: Fmt.number(reached),
              hint: 'across all channels',
              icon: Icons.campaign_outlined,
            ),
            StatCard(
              label: 'Average open rate',
              value: '$avgOpen%',
              hint: 'email and SMS combined',
              icon: Icons.drafts_outlined,
            ),
            StatCard(
              label: 'Scheduled',
              value: '$scheduled',
              hint: 'queued to send',
              icon: Icons.schedule_send_outlined,
            ),
          ],
        ),
        SplitRow(
          primary: SectionCard(
            title: 'Campaign history',
            description: 'Every message with its audience and outcome.',
            child: Column(
              children: [
                for (final c in campaigns)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Icon(_channelIcon(c.channel),
                              size: 16,
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(width: AppSpacing.sm + 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(c.subject,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              Text(
                                '${c.audience} · ${Fmt.number(c.recipients)} recipients'
                                '${c.sentAt != null ? ' · sent ${Fmt.relative(c.sentAt!, appNow())}' : c.scheduledFor != null ? ' · sends ${Fmt.dateTime(c.scheduledFor!)}' : ''}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        if (c.openRate != null) ...[
                          Text('${c.openRate}% opened',
                              style: Theme.of(context).textTheme.labelSmall),
                          const SizedBox(width: 6),
                        ],
                        StatusBadge.of(c.status),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          secondary: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SectionCard(
                title: 'Reach by channel',
                description: 'Recipients per delivery channel.',
                child: DonutChart(data: channelData, height: 210),
              ),
              const SizedBox(height: AppSpacing.md + 4),
              SectionCard(
                title: 'Latest announcements',
                description: 'Notices on the member portal.',
                child: Column(
                  children: [
                    for (final a in ref.watch(announcementsProvider).take(4))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm + 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            Text(
                              '${ref.watch(memberNameProvider(a.authorId))} · '
                              '${Fmt.relative(a.postedAt, appNow())}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
