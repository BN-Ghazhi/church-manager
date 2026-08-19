import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

import '../providers/permissions.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'reports_screen.dart';

/// Dashboard and Reports on one page.
///
/// They answer the same question — how is the church doing — and having them as
/// two sidebar entries meant leaving the dashboard to export the very figures
/// you were looking at. Tabs keep both a click apart and shorten the nav by one
/// item. The Reports tab is hidden from anyone without the Reports permission,
/// which is what the separate route used to enforce.
class OverviewScreen extends ConsumerStatefulWidget {
  const OverviewScreen({super.key, this.initialTab = 0});

  /// 1 opens on Reports — used by the old `/reports` route and the Export button.
  final int initialTab;

  @override
  ConsumerState<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends ConsumerState<OverviewScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabs;
  bool? _hadReports;

  @override
  void dispose() {
    _tabs?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSeeReports = ref.watch(canViewProvider('Reports'));

    // The controller's length depends on a permission, which can change when a
    // Super Admin edits their own access, so it is rebuilt when that happens
    // rather than assumed fixed for the life of the screen.
    if (_tabs == null || _hadReports != canSeeReports) {
      _tabs?.dispose();
      _tabs = TabController(
        length: canSeeReports ? 2 : 1,
        initialIndex: canSeeReports ? widget.initialTab.clamp(0, 1) : 0,
        vsync: this,
      );
      _hadReports = canSeeReports;
    }

    if (!canSeeReports) return const DashboardScreen();

    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: TabBar(
              controller: _tabs,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              labelColor: scheme.primary,
              unselectedLabelColor: scheme.onSurfaceVariant,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(icon: Icon(Icons.dashboard_outlined, size: 18), text: 'Dashboard'),
                Tab(icon: Icon(Icons.bar_chart_outlined, size: 18), text: 'Reports'),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.6)),
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: const [DashboardScreen(), ReportsScreen()],
          ),
        ),
      ],
    );
  }
}
