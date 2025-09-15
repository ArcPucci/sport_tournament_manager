import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/widgets/menu/custom_popup_menu.dart';

import '../../utils/utils.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({super.key, this.onEdit, this.onDelete});

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
          Image.asset(
            'assets/png/player_logo_1.png',
            width: 37.r,
            height: 37.r,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 8.w),
          Expanded(child: Text("Player 1", style: AppTextStyles.ts12_500)),
          CustomPopupMenu(onEdit: onEdit, onDelete: onDelete),
        ],
      ),
    );
  }
}
