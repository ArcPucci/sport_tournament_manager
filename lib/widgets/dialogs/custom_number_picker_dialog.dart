import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import '../widgets.dart';

class CustomNumberPickerDialog extends StatefulWidget {
  const CustomNumberPickerDialog({
    super.key,
    required this.onSave,
    required this.title,
  });

  final String title;
  final void Function(int) onSave;

  @override
  State<CustomNumberPickerDialog> createState() =>
      _CustomNumberPickerDialogState();
}

class _CustomNumberPickerDialogState extends State<CustomNumberPickerDialog> {
  final FixedExtentScrollController _controller = FixedExtentScrollController(
    initialItem: 1,
  );
  int _selected = 2;

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
                    onSelectedItemChanged: (index) =>
                        setState(() => _selected = index + 1),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 20,
                      builder: (context, index) {
                        final number = index + 1;
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
