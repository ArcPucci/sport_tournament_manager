import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 186.h,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 310.w,
            height: 80.r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/png/helm.png',
                      width: 66.r,
                      height: 66.r,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 228.w,
                      height: 80.r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tournament 1",
                                style: AppTextStyles.kp20_700,
                              ),
                              Text(
                                "08/23/2025\n08 AM",
                                style: AppTextStyles.ts12_400,
                              ),
                            ],
                          ),
                          Row(
                            children: List.generate(
                              2,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 5.h,
                                  ),
                                  child: Text(
                                    "data",
                                    style: AppTextStyles.ts16_400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Teams:", style: AppTextStyles.ts12_500),
                      SizedBox(width: 7.r),
                      Text("2/10", style: AppTextStyles.ts12_400),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text("Locations:", style: AppTextStyles.ts12_500),
                      SizedBox(width: 7.r),
                      Text("2/10", style: AppTextStyles.ts12_400),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/png/edit.png',
                    width: 24.r,
                    height: 24.r,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 16.w),
                  Image.asset(
                    'assets/png/trash.png',
                    width: 24.r,
                    height: 24.r,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
