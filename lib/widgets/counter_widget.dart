import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.title,
    required this.value,
    this.onDecrease,
    this.onIncrease,
  });

  final String title;
  final int value;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.ts16_400),
        SizedBox(
          width: 105.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onDecrease,
                child: Image.asset(
                  'assets/png/minus.png',
                  width: 25.r,
                  height: 25.r,
                  fit: BoxFit.fill,
                ),
              ),
              Text("$value", style: AppTextStyles.ts16_600),
              GestureDetector(
                onTap: onIncrease,
                child: Image.asset(
                  'assets/png/plus2.png',
                  width: 25.r,
                  height: 25.r,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
