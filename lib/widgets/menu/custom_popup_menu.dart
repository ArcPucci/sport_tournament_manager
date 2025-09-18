import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';

class CustomPopupMenu extends StatefulWidget {
  const CustomPopupMenu({
    super.key,
    this.canDelete = true,
    this.onEdit,
    this.onDelete,
  });

  final bool canDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.grey2,
      offset: Offset(-20.r, 36.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.lightGrey),
      ),
      menuPadding: EdgeInsets.zero,
      icon: Opacity(
        opacity: _opened ? 0.4 : 1,
        child: Image.asset(
          'assets/png/dotes.png',
          width: 24.r,
          height: 24.r,
          fit: BoxFit.fill,
        ),
      ),
      onOpened: () => setState(() => _opened = true),
      onCanceled: () => setState(() => _opened = false),
      onSelected: (value) {
        if (value == 'edit') {
          widget.onEdit?.call();
        } else if (value == 'delete') {
          widget.onDelete?.call();
        }

        setState(() => _opened = false);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: 182.w,
            height: 37.h,
            child: Center(child: Text("Edit", style: AppTextStyles.ts12_500)),
          ),
        ),
        if (widget.canDelete) ...[
          PopupMenuDivider(height: 1.sp, color: AppColors.lightGrey),
          PopupMenuItem(
            value: 'delete',
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: 182.w,
              height: 37.h,
              child: Center(
                child: Text("Delete", style: AppTextStyles.ts12_500),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
