import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

import '../../utils/utils.dart';

class CustomNumberPickerDialog extends StatefulWidget {
  const CustomNumberPickerDialog({
    super.key,
    this.min = 1,
    this.max = 10,
    required this.onSave,
    required this.title,
  });

  final int min;
  final int max;
  final String title;
  final void Function(int) onSave;

  @override
  State<CustomNumberPickerDialog> createState() =>
      _CustomNumberPickerDialogState();
}

class _CustomNumberPickerDialogState extends State<CustomNumberPickerDialog> {
  late FixedExtentScrollController _controller;
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.min;
    _controller = FixedExtentScrollController(
      initialItem: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 256.h,
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 27.h,
            bottom: 24.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.ts16_600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 30.w,
                  height: 89.h,
                  child: ListWheelScrollView.useDelegate(
                    controller: _controller,
                    itemExtent: 43,
                    perspective: 0.005,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selected = widget.min + index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: widget.max - widget.min + 1,
                      builder: (context, index) {
                        final number = widget.min + index;
                        return Center(
                          child: Text(
                            number.toString(),
                            style: number == _selected
                                ? AppTextStyles.kp24_700
                                : AppTextStyles.ts16_600.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CustomButton1(
                  text: "Save",
                  width: 334.w,
                  height: 40.h,
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onSave(_selected);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 24.h,
            right: 24.w,
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Image.asset(
                'assets/png/close.png',
                width: 34.r,
                height: 34.r,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
