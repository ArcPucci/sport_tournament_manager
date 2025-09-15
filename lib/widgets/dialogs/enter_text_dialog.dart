import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import '../widgets.dart';

class EnterTextDialog extends StatelessWidget {
  const EnterTextDialog({super.key, required this.text, required this.onSave});

  final String text;
  final void Function(String) onSave;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 358.w,
        height: 244.h,
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
                    text,
                    style: AppTextStyles.ts16_600,
                    textAlign: TextAlign.center,
                  ),
                  CustomInput2(),
                  Column(
                    children: [
                      SizedBox(height: 8.h),
                      CustomButton1(
                        text: "Save",
                        width: 334.w,
                        height: 40.h,
                        onTap: () {
                          onSave.call("");
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
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
      ),
    );
  }
}
