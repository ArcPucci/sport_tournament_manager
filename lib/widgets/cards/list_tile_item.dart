import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/widgets/menu/custom_popup_menu.dart';

import '../../utils/utils.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    this.onEdit,
    this.onDelete,
    required this.name,
    this.icon,
    this.textStyle,
    this.canDelete = true,
  });

  final String name;
  final String? icon;
  final bool canDelete;
  final TextStyle? textStyle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          if (icon != null)
            Image.asset(icon!, width: 37.r, height: 37.r, fit: BoxFit.fill),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(name, style: textStyle ?? AppTextStyles.ts12_500),
          ),
          CustomPopupMenu(
            canDelete: canDelete,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}
