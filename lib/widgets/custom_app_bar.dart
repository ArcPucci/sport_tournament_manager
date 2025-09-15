import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: context.pop,
            child: Image.asset(
              'assets/png/back.png',
              width: 26.r,
              height: 24.r,
              fit: BoxFit.fill,
            ),
          ),
          Text(title, style: AppTextStyles.ts16_600),
          SizedBox(width: 26.r),
        ],
      ),
    );
  }
}
