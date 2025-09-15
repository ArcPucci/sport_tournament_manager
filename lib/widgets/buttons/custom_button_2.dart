import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 334.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2.sp, color: AppColors.red),
        ),
        alignment: Alignment.center,
        child: Text(text, style: AppTextStyles.ts17_500),
      ),
    );
  }
}
