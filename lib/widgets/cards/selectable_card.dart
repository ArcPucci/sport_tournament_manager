import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class SelectableCard extends StatelessWidget {
  const SelectableCard({
    super.key,
    required this.text,
    this.selected = false,
    this.onSelect,
  });

  final String text;
  final bool selected;
  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.red : AppColors.grey2,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.h),
        child: Text(text, style: AppTextStyles.ts16_400),
      ),
    );
  }
}
