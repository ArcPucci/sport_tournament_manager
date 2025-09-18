import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class ScheduleTypesDialog extends StatefulWidget {
  const ScheduleTypesDialog({super.key, required this.onSave});

  final void Function(int) onSave;

  @override
  State<ScheduleTypesDialog> createState() => _ScheduleTypesDialogState();
}

class _ScheduleTypesDialogState extends State<ScheduleTypesDialog> {
  final list = ["Random schedule", "Configure manually"];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 232.h,
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 310.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 34.r),
                Text("Choose a schedule type", style: AppTextStyles.ts16_600),
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Image.asset(
                    'assets/png/close.png',
                    width: 34.r,
                    height: 34.r,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 310.w,
            child: Column(
              children: List.generate(list.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(top: index != 0 ? 16.h : 0),
                  child: GestureDetector(
                    onTap: () {
                      _selected = index;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        CustomCheckButton(
                          isSelected: index == _selected,
                          onTap: () {
                            _selected = index;
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 12.w),
                        Text(list[index], style: AppTextStyles.ts17_500),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          CustomButton1(
            text: "Go",
            width: 334.w,
            height: 40.h,
            onTap: () {
              Navigator.of(context).pop();
              widget.onSave.call(_selected);
            },
          ),
        ],
      ),
    );
  }
}
