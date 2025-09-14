import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class CustomSearchBox extends StatelessWidget {
  CustomSearchBox({super.key});

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        width: 358.w,
        height: 42.h,
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                style: AppTextStyles.ts16_400,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                  hintStyle: AppTextStyles.ts16_400.copyWith(
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/png/search.png',
              width: 26.r,
              height: 26.r,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
