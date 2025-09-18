import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../../utils/utils.dart';

class TabCard extends StatelessWidget {
  const TabCard({
    super.key,
    this.selected = false,
    required this.tab,
    this.onTap,
  });

  final bool selected;
  final CustomTab tab;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: selected ? AppColors.red : AppColors.grey2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(tab.icon, width: 23.r, height: 24.r, fit: BoxFit.fill),
            SizedBox(width: 4.w),
            Text(
              tab.text,
              style: AppTextStyles.ts14_400.copyWith(
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
