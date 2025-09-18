import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class IOSCalendarPicker extends StatefulWidget {
  const IOSCalendarPicker({
    super.key,
    required this.onChanged,
    this.initialDate,
  });

  final DateTime? initialDate;
  final void Function(DateTime) onChanged;

  @override
  State<IOSCalendarPicker> createState() => _IOSCalendarPickerState();
}

class _IOSCalendarPickerState extends State<IOSCalendarPicker> {
  final DateTime _focusedDay = DateTime.now().copyWith(hour: 8);
  DateTime _selectedDay = DateTime.now().copyWith(hour: 8);
  bool isAm = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) _selectedDay = widget.initialDate!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361.w,
      height: 384.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          Expanded(
            child: CustomCalendar(
              initialDate: widget.initialDate,
              onChanged: (date) {
                _selectedDay = _selectedDay.copyWith(
                  year: date.year,
                  month: date.month,
                  day: date.day,
                );
                widget.onChanged.call(_selectedDay);
                setState(() {});
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 345.w,
              height: 1.sp,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ),
          SizedBox(
            width: 329.w,
            height: 44.h,
            child: Row(
              children: [
                Text("Ends", style: AppTextStyles.ts17_400),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final time = await showCupertinoModalPopup<TimeOfDay>(
                      context: context,
                      builder: (_) => Container(
                        height: 250,
                        color: Colors.white,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: false,
                          initialDateTime: DateTime(
                            0,
                            0,
                            0,
                            _selectedDay.hour,
                            _selectedDay.minute,
                          ),
                          onDateTimeChanged: (dt) {
                            setState(() {
                              _selectedDay = _selectedDay.copyWith(
                                hour: dt.hour,
                                minute: dt.minute,
                              );
                              widget.onChanged.call(_selectedDay);
                              isAm = dt.hour < 12;
                            });
                          },
                        ),
                      ),
                    );
                    if (time != null) {
                      setState(() {
                        _selectedDay = _selectedDay.copyWith(
                          hour: time.hour,
                          minute: time.minute,
                        );
                        widget.onChanged.call(_selectedDay);
                      });
                    }
                  },
                  child: Container(
                    width: 69.w,
                    height: 34.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF767680).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      TimeOfDay(
                        hour: _selectedDay.hour,
                        minute: _selectedDay.minute,
                      ).format(context),
                      style: AppTextStyles.ts17_400,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 85.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF767680).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                  child: Stack(
                    alignment: isAm
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    children: [
                      Container(
                        width: 41.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            width: 0.5.sp,
                            color: Colors.black.withValues(alpha: 0.04),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 1,
                              color: Colors.black.withValues(alpha: 0.04),
                            ),
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 8,
                              color: Colors.black.withValues(alpha: 0.12),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (index) {
                            return GestureDetector(
                              onTap: () => setState(() => isAm = index == 0),
                              child: Container(
                                width: 41.w,
                                height: 30.h,
                                color: Colors.transparent,
                                child: Center(
                                  child: Text(
                                    index == 0 ? "AM" : "PM",
                                    style: AppTextStyles.ts13_500,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
