import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';

class SearchDateRangePicker extends StatefulWidget {
  final DateTimeRange? selectedRange;
  final ValueChanged<DateTimeRange>? onRangeSelected;

  const SearchDateRangePicker({
    super.key,
    this.selectedRange,
    this.onRangeSelected,
  });

  @override
  State<SearchDateRangePicker> createState() => _SearchDateRangePickerState();
}

class _SearchDateRangePickerState extends State<SearchDateRangePicker> {
  late DateTime _displayMonth;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _displayMonth = DateTime.now();
    _rangeStart = widget.selectedRange?.start;
    _rangeEnd = widget.selectedRange?.end;
  }

  @override
  void didUpdateWidget(SearchDateRangePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedRange != oldWidget.selectedRange) {
      _rangeStart = widget.selectedRange?.start;
      _rangeEnd = widget.selectedRange?.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _displayMonth = DateTime(
                    _displayMonth.year,
                    _displayMonth.month - 1,
                  );
                });
              },
              icon: const Icon(Icons.chevron_left),
              color: AppColors.ink,
            ),
            Text(
              '${_monthName(_displayMonth.month)} ${_displayMonth.year}',
              style: AppTypography.titleSm.copyWith(color: AppColors.ink),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _displayMonth = DateTime(
                    _displayMonth.year,
                    _displayMonth.month + 1,
                  );
                });
              },
              icon: const Icon(Icons.chevron_right),
              color: AppColors.ink,
            ),
          ],
        ),

        // Day of week header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: AppTypography.captionSm.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Calendar grid
        _buildCalendarGrid(_displayMonth),

        // Selected range display
        if (_rangeStart != null && _rangeEnd != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${DateFmt.monthDay(_rangeStart!)} – ${DateFmt.monthDay(_rangeEnd!)}',
                  style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${DateFmt.nightsBetween(_rangeStart!, _rangeEnd!)} nights',
                  style: AppTypography.bodySm.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCalendarGrid(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final startWeekday = firstDay.weekday % 7; // Sunday = 0
    final totalDays = lastDay.day;

    final cells = <Widget>[];

    // Empty cells for days before the first day
    for (int i = 0; i < startWeekday; i++) {
      cells.add(const SizedBox.shrink());
    }

    // Day cells
    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(month.year, month.month, day);
      final isPast = date.isBefore(
        DateTime.now().subtract(const Duration(days: 1)),
      );
      final isStart =
          _rangeStart != null && _isSameDay(date, _rangeStart!);
      final isEnd = _rangeEnd != null && _isSameDay(date, _rangeEnd!);
      final isInRange = _rangeStart != null &&
          _rangeEnd != null &&
          date.isAfter(_rangeStart!) &&
          date.isBefore(_rangeEnd!);

      cells.add(
        GestureDetector(
          onTap: isPast ? null : () => _onDayTap(date),
          child: Container(
            decoration: BoxDecoration(
              color: isStart || isEnd
                  ? AppColors.ink
                  : isInRange
                      ? AppColors.ink.withValues(alpha: 0.08)
                      : null,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: AppTypography.bodySm.copyWith(
                color: isPast
                    ? AppColors.mutedSoft
                    : isStart || isEnd
                        ? AppColors.onDark
                        : AppColors.ink,
                fontWeight:
                    isStart || isEnd ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: GridView.count(
        crossAxisCount: 7,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: cells,
      ),
    );
  }

  void _onDayTap(DateTime date) {
    setState(() {
      if (_rangeStart == null || _rangeEnd != null) {
        _rangeStart = date;
        _rangeEnd = null;
      } else if (date.isAfter(_rangeStart!)) {
        _rangeEnd = date;
        widget.onRangeSelected?.call(
          DateTimeRange(start: _rangeStart!, end: _rangeEnd!),
        );
      } else {
        _rangeStart = date;
        _rangeEnd = null;
      }
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return months[month - 1];
  }
}
