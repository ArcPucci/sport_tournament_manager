import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.title, this.onDelete});

  final String title;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  title,
                  style: AppTextStyles.ts16_600,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "This action cannot be undone.",
                  style: AppTextStyles.ts14_400.copyWith(
                    decoration: TextDecoration.none,
                  ),
                ),
                Column(
                  children: [
                    CustomButton2(
                      text: "Yes",
                      onTap: () {
                        Navigator.of(context).pop();
                        onDelete?.call();
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomButton1(
                      text: "No",
                      width: 334.w,
                      height: 40.h,
                      onTap: Navigator.of(context).pop,
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
    );
  }
}
