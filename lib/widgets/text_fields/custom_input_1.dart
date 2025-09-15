import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class CustomInput1 extends StatelessWidget {
  CustomInput1({super.key, this.controller});

  final focusNode = FocusNode();
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        width: 358.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          style: AppTextStyles.ts16_400,
          decoration: InputDecoration.collapsed(
            hintText: 'Tournament name',
            hintStyle: AppTextStyles.ts16_400.copyWith(color: AppColors.grey3),
          ),
        ),
      ),
    );
  }
}
