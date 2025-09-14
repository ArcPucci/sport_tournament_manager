import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({
    super.key,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
  });

  final int selected;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 13.r,
            height: 13.r,
            decoration: BoxDecoration(
              color: selected == index ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
