import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390.w,
      height: 95.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 390.w,
              height: 82.h,
              color: AppColors.black,
              padding: EdgeInsets.symmetric(horizontal: 27.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 79.w,
                    height: 58.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/png/game.png',
                          width: 43.r,
                          height: 43.r,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          "Games",
                          style: AppTextStyles.ts12_500.copyWith(
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 79.w,
                    height: 58.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/png/cup.png',
                          width: 38.r,
                          height: 38.r,
                          fit: BoxFit.fill,
                        ),
                        Text("Tournaments", style: AppTextStyles.ts12_500),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              height: 84.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/png/plus.png',
                    width: 61.r,
                    height: 61.r,
                    fit: BoxFit.fill,
                  ),
                  Text("Create", style: AppTextStyles.ts12_500),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
