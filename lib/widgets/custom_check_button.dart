import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

class CustomCheckButton extends StatelessWidget {
  const CustomCheckButton({super.key, this.isSelected = false, this.onTap});

  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.r,
        height: 20.r,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        alignment: Alignment.center,
        child: isSelected
            ? Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.red,
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
