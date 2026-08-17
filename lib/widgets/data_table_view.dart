import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'person_tile.dart';

/// One column of a [DataTableView].
class TableColumn<T> {
  const TableColumn({
    required this.id,
    required this.header,
    required this.cell,
    this.sortValue,
    this.flex = 1,
    this.width,
    this.alignEnd = false,
    this.hideOnNarrow = false,
  });

  final String id;
  final String header;
  final Widget Function(T row) cell;

  /// Return a Comparable to make the column sortable; omit to disable sorting.
  final Comparable Function(T row)? sortValue;

  /// Proportional width when [width] is not set.
  final int flex;

  /// Fixed width in logical pixels.
  final double? width;
  final bool alignEnd;

  /// Dropped below the medium breakpoint so wide tables degrade gracefully.
  final bool hideOnNarrow;
}

/// A dropdown filter over the table's rows.
class TableFilter<T> {
  const TableFilter({
    required this.id,
    required this.label,
    required this.options,
    required this.matches,
  });

  final String id;
  final String label;
  final List<String> options;

  /// True when [row] should be kept for the selected [value].
  final bool Function(T row, String value) matches;
}

/// One table to serve every module.
///
/// Sorting, searching, filtering and pagination all happen in memory over the
/// list it is given. When the API lands, swap this internal pipeline for server
/// parameters without touching a single call site.
class DataTableView<T> extends StatefulWidget {
  const DataTableView({
    super.key,
    required this.rows,
    required this.columns,
    required this.rowId,
    this.searchable,
    this.searchHint = 'Search…',
    this.filters = const [],
    this.pageSize = 10,
    this.onRowTap,
    this.toolbarAction,
    this.initialSortId,
    this.initialSortDescending = false,
    this.emptyTitle = 'Nothing to show',
    this.emptyDescription = 'Try adjusting your search or filters.',
  });

  final List<T> rows;
  final List<TableColumn<T>> columns;
  final String Function(T row) rowId;

  /// Fields concatenated and matched against the search box.
  final String Function(T row)? searchable;
  final String searchHint;
  final List<TableFilter<T>> filters;
  final int pageSize;
  final void Function(T row)? onRowTap;

  /// Rendered at the end of the toolbar (e.g. an "Add" button).
  final Widget? toolbarAction;

  /// Column to sort by on first build. Without it the rows appear in the order
  /// the repository returned them.
  final String? initialSortId;
  final bool initialSortDescending;
  final String emptyTitle;
  final String emptyDescription;

  @override
  State<DataTableView<T>> createState() => _DataTableViewState<T>();
}

class _DataTableViewState<T> extends State<DataTableView<T>> {
  final _searchController = TextEditingController();
  String _query = '';
  String? _sortId;
  bool _sortDescending = false;
  final Map<String, String> _filterValues = {};
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _sortId = widget.initialSortId;
    _sortDescending = widget.initialSortDescending;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<T> get _filtered {
    var rows = widget.rows;

    final needle = _query.trim().toLowerCase();
    if (needle.isNotEmpty && widget.searchable != null) {
      rows = rows
          .where((r) => widget.searchable!(r).toLowerCase().contains(needle))
          .toList();
    }

    for (final filter in widget.filters) {
      final value = _filterValues[filter.id];
      if (value == null) continue;
      rows = rows.where((r) => filter.matches(r, value)).toList();
    }

    if (_sortId != null) {
      final column =
          widget.columns.where((c) => c.id == _sortId).firstOrNull;
      if (column?.sortValue != null) {
        rows = [...rows]..sort((a, b) {
            final result =
                column!.sortValue!(a).compareTo(column.sortValue!(b));
            return _sortDescending ? -result : result;
          });
      }
    }

    return rows;
  }

  void _toggleSort(String id) {
    setState(() {
      if (_sortId != id) {
        _sortId = id;
        _sortDescending = false;
      } else if (!_sortDescending) {
        _sortDescending = true;
      } else {
        _sortId = null;
        _sortDescending = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final narrow = width < AppBreakpoints.medium;

    final columns =
        widget.columns.where((c) => !(narrow && c.hideOnNarrow)).toList();

    final filtered = _filtered;
    final pageCount = (filtered.length / widget.pageSize).ceil().clamp(1, 9999);
    final page = _page.clamp(0, pageCount - 1);
    final start = page * widget.pageSize;
    final visible = filtered.skip(start).take(widget.pageSize).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildToolbar(context, narrow),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.7)),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Header row
              Container(
                color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm + 2,
                ),
                child: Row(
                  children: [
                    for (final column in columns)
                      _cellBox(
                        column,
                        _HeaderCell(
                          column: column,
                          sorted: _sortId == column.id,
                          descending: _sortDescending,
                          onTap: column.sortValue == null
                              ? null
                              : () => _toggleSort(column.id),
                        ),
                      ),
                  ],
                ),
              ),
              if (visible.isEmpty)
                EmptyState(
                  title: widget.emptyTitle,
                  description: widget.emptyDescription,
                  icon: Icons.search_off,
                )
              else
                for (final row in visible)
                  _TableRow<T>(
                    key: ValueKey(widget.rowId(row)),
                    row: row,
                    columns: columns,
                    onTap: widget.onRowTap,
                    cellBox: _cellBox,
                  ),
            ],
          ),
        ),
        if (filtered.length > widget.pageSize) ...[
          const SizedBox(height: AppSpacing.sm + 4),
          _buildPagination(context, page, pageCount, filtered.length, start),
        ],
      ],
    );
  }

  Widget _cellBox(TableColumn<T> column, Widget child) {
    final aligned = Align(
      alignment: column.alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: child,
    );
    if (column.width != null) {
      return SizedBox(width: column.width, child: aligned);
    }
    return Expanded(flex: column.flex, child: aligned);
  }

  Widget _buildToolbar(BuildContext context, bool narrow) {
    final hasSearch = widget.searchable != null;
    if (!hasSearch && widget.filters.isEmpty && widget.toolbarAction == null) {
      return const SizedBox.shrink();
    }

    final controls = <Widget>[
      if (hasSearch)
        SizedBox(
          width: narrow ? double.infinity : 280,
          child: TextField(
            controller: _searchController,
            onChanged: (v) => setState(() {
              _query = v;
              _page = 0;
            }),
            decoration: InputDecoration(
              hintText: widget.searchHint,
              prefixIcon: const Icon(Icons.search, size: 18),
              isDense: true,
            ),
          ),
        ),
      for (final filter in widget.filters)
        _FilterDropdown(
          label: filter.label,
          options: filter.options,
          value: _filterValues[filter.id],
          onChanged: (v) => setState(() {
            if (v == null) {
              _filterValues.remove(filter.id);
            } else {
              _filterValues[filter.id] = v;
            }
            _page = 0;
          }),
        ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: controls,
          ),
        ),
        if (widget.toolbarAction != null) ...[
          const SizedBox(width: AppSpacing.sm),
          widget.toolbarAction!,
        ],
      ],
    );
  }

  Widget _buildPagination(
    BuildContext context,
    int page,
    int pageCount,
    int total,
    int start,
  ) {
    final theme = Theme.of(context);
    final end = (start + widget.pageSize).clamp(0, total);

    return Row(
      children: [
        Expanded(
          child: Text(
            'Showing ${start + 1}–$end of $total',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        IconButton(
          onPressed: page == 0 ? null : () => setState(() => _page = page - 1),
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Previous page',
        ),
        Text(
          'Page ${page + 1} of $pageCount',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        IconButton(
          onPressed: page >= pageCount - 1
              ? null
              : () => setState(() => _page = page + 1),
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Next page',
        ),
      ],
    );
  }
}

class _HeaderCell<T> extends StatelessWidget {
  const _HeaderCell({
    required this.column,
    required this.sorted,
    required this.descending,
    this.onTap,
  });

  final TableColumn<T> column;
  final bool sorted;
  final bool descending;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurfaceVariant,
    );

    if (onTap == null) return Text(column.header, style: style);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text(column.header, style: style, overflow: TextOverflow.ellipsis)),
            const SizedBox(width: 3),
            Icon(
              sorted
                  ? (descending ? Icons.arrow_downward : Icons.arrow_upward)
                  : Icons.unfold_more,
              size: 13,
              color: sorted
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _TableRow<T> extends StatelessWidget {
  const _TableRow({
    super.key,
    required this.row,
    required this.columns,
    required this.cellBox,
    this.onTap,
  });

  final T row;
  final List<TableColumn<T>> columns;
  final Widget Function(TableColumn<T>, Widget) cellBox;
  final void Function(T row)? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap == null ? null : () => onTap!(row),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        child: Row(
          children: [
            for (final column in columns) cellBox(column, column.cell(row)),
          ],
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 4),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: value,
          hint: Text(label, style: Theme.of(context).textTheme.bodySmall),
          icon: const Icon(Icons.expand_more, size: 18),
          borderRadius: BorderRadius.circular(AppRadius.md),
          style: Theme.of(context).textTheme.bodySmall,
          isDense: true,
          items: [
            DropdownMenuItem<String?>(
              value: null,
              child: Text('All ${label.toLowerCase()}'),
            ),
            for (final option in options)
              DropdownMenuItem<String?>(value: option, child: Text(option)),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
