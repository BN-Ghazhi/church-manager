import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../providers/auth.dart';
import '../widgets/row_actions.dart';
import '../widgets/collapsible.dart';
import '../widgets/feedback.dart';
import '../providers/permissions.dart';
import '../models/models.dart';
import '../providers/repository.dart';
import '../utils/formatters.dart';
import '../widgets/charts.dart';
import '../widgets/data_table_view.dart';
import '../widgets/page_header.dart';
import '../widgets/record_forms.dart';
import '../widgets/page_scaffold.dart';
import '../widgets/section_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_badge.dart';

class AssetsScreen extends ConsumerWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assets = ref.watch(assetsProvider);
    final totalValue = assets.fold(0.0, (s, a) => s + a.value);
    final needsRepair =
        assets.where((a) => a.condition == AssetCondition.needsRepair).length;

    final byCategory = <String, double>{};
    for (final a in assets) {
      byCategory[a.category] = (byCategory[a.category] ?? 0) + a.value;
    }
    final categoryData = byCategory.entries
        .map((e) => CategoryPoint(label: e.key, value: e.value))
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final categories = byCategory.keys.toList()..sort();
    final locations = assets.map((a) => a.location).toSet().toList()..sort();

    return PageBody(
      children: [
        PageHeader(
          title: 'Assets',
          description:
              'Equipment register with condition, location and replacement value.',
          actions: [
            FilledButton.icon(
              onPressed: () => showAssetForm(context),
              icon: const Icon(Icons.add, size: 17),
              label: const Text('Register asset'),
            ),
          ],
        ),
        StatRow(
          sectionKey: 'assets.stats',
          minItemWidth: 250,
          maxColumns: 4,
          children: [
            StatCard(
              label: 'Assets tracked',
              value: Fmt.number(assets.length),
              hint: 'items on the register',
              icon: Icons.inventory_2_outlined,
            ),
            StatCard(
              label: 'Total value',
              value: Fmt.compactCurrency(totalValue),
              hint: 'at purchase cost',
              icon: Icons.account_balance_wallet_outlined,
            ),
            StatCard(
              label: 'Needs repair',
              value: '$needsRepair',
              hint: 'flagged for maintenance',
              icon: Icons.build_outlined,
              invertDelta: true,
            ),
            StatCard(
              label: 'Categories',
              value: '${categories.length}',
              hint: 'from audio to vehicles',
              icon: Icons.category_outlined,
            ),
          ],
        ),
        SectionCard(
          title: 'Value by category',
          description: "Where the church's capital is invested.",
          child: CategoryBarChart(
            data: categoryData,
            format: ValueFormat.currency,
            horizontal: true,
            height: 300,
          ),
        ),
        SectionCard(
          title: 'Asset register',
          description: 'Search and filter by category, condition or location.',
          child: DataTableView<AssetItem>(
            rows: assets,
            rowId: (a) => a.id,
            pageSize: 10,
            searchHint: 'Search by name or serial…',
            searchable: (a) => '${a.name} ${a.serial} ${a.category} ${a.location}',
            filters: [
              TableFilter<AssetItem>(
                id: 'category',
                label: 'Category',
                options: categories,
                matches: (a, v) => a.category == v,
              ),
              TableFilter<AssetItem>(
                id: 'condition',
                label: 'Condition',
                options: AssetCondition.values.map((c) => c.label).toList(),
                matches: (a, v) => a.condition.label == v,
              ),
              TableFilter<AssetItem>(
                id: 'location',
                label: 'Location',
                options: locations,
                matches: (a, v) => a.location == v,
              ),
            ],
            columns: [
              TableColumn<AssetItem>(
                id: 'name',
                header: 'Asset',
                flex: 4,
                sortValue: (a) => a.name,
                cell: (a) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(a.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    Text(a.serial,
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
              TableColumn<AssetItem>(
                id: 'category',
                header: 'Category',
                flex: 2,
                sortValue: (a) => a.category,
                cell: (a) => Text(a.category,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<AssetItem>(
                id: 'location',
                header: 'Location',
                flex: 2,
                hideOnNarrow: true,
                sortValue: (a) => a.location,
                cell: (a) => Text(a.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              TableColumn<AssetItem>(
                id: 'condition',
                header: 'Condition',
                width: 130,
                sortValue: (a) => a.condition.label,
                cell: (a) => StatusBadge.of(a.condition),
              ),
              TableColumn<AssetItem>(
                id: 'value',
                header: 'Value',
                flex: 2,
                alignEnd: true,
                sortValue: (a) => a.value,
                cell: (a) => Text(
                  Fmt.currency(a.value),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              TableColumn<AssetItem>(
                id: 'actions',
                header: '',
                width: 116,
                cell: (a) => RowActions(
                  onView: () => _showAsset(context, ref, a),
                  onEdit: () => showAssetForm(context, asset: a),
                  onDelete: () => _deleteAsset(context, ref, a),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _showAsset(BuildContext context, WidgetRef ref, AssetItem asset) {
  showDetailSheet<void>(
    context,
    title: asset.name,
    subtitle: '${asset.category} · ${asset.condition.label}',
    children: [
      DetailRows(entries: {
        'Category': asset.category,
        'Serial number': asset.serial,
        'Condition': asset.condition.label,
        'Location': asset.location,
        'Purchased': Fmt.date(asset.purchasedAt),
        'Value': Fmt.currency(asset.value),
        'Branch': ref.read(branchNameProvider(asset.branchId)),
      }),
    ],
    actions: [
      if (ref.read(canEditProvider('Assets')))
        OutlinedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            showAssetForm(context, asset: asset);
          },
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit'),
        ),
    ],
  );
}

Future<void> _deleteAsset(
  BuildContext context,
  WidgetRef ref,
  AssetItem asset,
) async {
  final ok = await confirmDelete(
    context,
    what: asset.name,
    consequence: 'It leaves the register, and the total asset value drops by '
        '${Fmt.currency(asset.value)}.',
  );
  if (!ok || !context.mounted) return;
  await ref.read(repositoryProvider).deleteAsset(asset.id);
  if (!context.mounted) return;
  showLocalSuccess(context, '${asset.name} removed from the register.');
}
