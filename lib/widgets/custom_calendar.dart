import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sport_tournament_manager/utils/utils.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key, required this.onChanged, this.initialDate});

  final DateTime? initialDate;
  final void Function(DateTime) onChanged;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) _selectedDay = widget.initialDate!;
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    final firstDayToDisplay = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday % 7),
    );
    final lastDayToDisplay = lastDayOfMonth.add(
      Duration(days: 6 - (lastDayOfMonth.weekday % 7)),
    );

    return List.generate(
      lastDayToDisplay.difference(firstDayToDisplay).inDays + 1,
      (i) => DateTime(
        firstDayToDisplay.year,
        firstDayToDisplay.month,
        firstDayToDisplay.day + i,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = _daysInMonth(_focusedMonth);
    final monthName = DateFormat.MMMM().format(_focusedMonth);
    final year = _focusedMonth.year;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 44.h,
          child: Row(
            children: [
              SizedBox(width: 16.w),
              GestureDetector(
                onTap: _showMonthYearPicker,
                child: Row(
                  children: [
                    Text(
                      "$monthName $year",
                      style: AppTextStyles.ts17_500.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Image.asset('assets/png/arrow_right_2.png', height: 12.r),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _focusedMonth = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month - 1,
                        );
                      });
                    },
                    child: Transform.rotate(
                      angle: pi,
                      child: Image.asset(
                        'assets/png/arrow_right_2.png',
                        height: 16.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 28.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _focusedMonth = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month + 1,
                        );
                      });
                    },
                    child: Image.asset(
                      'assets/png/arrow_right_2.png',
                      height: 16.r,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (index) {
            final weekday = DateFormat.E().format(DateTime(2023, 1, index + 1));
            return SizedBox(
              width: 32.w,
              child: Center(
                child: Text(
                  weekday.toUpperCase(),
                  style: AppTextStyles.ts13_600.copyWith(
                    color: Color(0xFF3C3C43).withValues(alpha: 0.3),
                  ),
                ),
              ),
            );
          }),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 44.h,
            ),
            itemBuilder: (context, index) {
              final day = days[index];
              final isToday =
                  day.year == DateTime.now().year &&
                  day.month == DateTime.now().month &&
                  day.day == DateTime.now().day;
              final isSelected =
                  day.year == _selectedDay.year &&
                  day.month == _selectedDay.month &&
                  day.day == _selectedDay.day;
              final isCurrentMonth = day.month == _focusedMonth.month;

              if (!isCurrentMonth) return SizedBox();

              return GestureDetector(
                onTap: () {
                  if (isCurrentMonth) {
                    widget.onChanged(day);
                    setState(() => _selectedDay = day);
                  }
                },
                child: Container(
                  decoration: isSelected
                      ? BoxDecoration(
                          color: AppColors.red.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        )
                      : null,
                  alignment: Alignment.center,
                  child: Text(
                    "${day.day}",
                    style: AppTextStyles.ts20_400.copyWith(
                      color: isToday || isSelected ? AppColors.red : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showMonthYearPicker() {
    final months = List.generate(
      12,
      (i) => DateFormat.MMMM().format(DateTime(0, i + 1)),
    );
    final years = List.generate(50, (i) => 2000 + i);

    int selectedMonth = _focusedMonth.month - 1;
    int selectedYear = years.indexOf(_focusedMonth.year);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedMonth,
                  ),
                  itemExtent: 40,
                  onSelectedItemChanged: (i) {
                    selectedMonth = i;
                  },
                  children: months.map((m) => Center(child: Text(m))).toList(),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedYear,
                  ),
                  itemExtent: 40,
                  onSelectedItemChanged: (i) {
                    selectedYear = i;
                  },
                  children: years
                      .map((y) => Center(child: Text(y.toString())))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      setState(() {
        _focusedMonth = DateTime(years[selectedYear], selectedMonth + 1, 1);
      });
    });
  }
}
