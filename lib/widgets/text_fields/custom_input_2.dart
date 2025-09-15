import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class CustomInput2 extends StatelessWidget {
  CustomInput2({super.key, this.controller});

  final focusNode = FocusNode();
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        width: 334.w,
        height: 37.h,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          style: AppTextStyles.ts16_400,
          decoration: InputDecoration.collapsed(hintText: ''),
        ),
      ),
    );
  }
}
