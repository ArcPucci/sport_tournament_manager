import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/providers/providers.dart';

import '../../utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class PremiumSheet extends StatelessWidget {
  const PremiumSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 390.w,
        height: 430.h,
        decoration: BoxDecoration(
          color: AppColors.black,
          border: Border(
            top: BorderSide(width: 1.sp, color: Colors.white),
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(height: 27.h),
              SizedBox(
                width: 350.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 34.r),
                    Text(
                      "Go Unlimited!",
                      style: AppTextStyles.kp20_700.copyWith(
                        color: AppColors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: Image.asset(
                        'assets/png/close.png',
                        width: 34.r,
                        height: 34.r,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Take your tournaments to the next level.",
                style: AppTextStyles.kp16_400,
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 303.w,
                child: Text(
                  "✅ Unlimited tournaments every month (Free: up to 5)\n✅ No limits. No restrictions. Just pure competition.",
                  style: AppTextStyles.kp16_400,
                ),
              ),
              Expanded(
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(text: "Try ", style: AppTextStyles.kp20_700),
                        TextSpan(
                          text: "Premium",
                          style: AppTextStyles.kp20_700.copyWith(
                            color: AppColors.red,
                          ),
                        ),
                        TextSpan(
                          text:
                              " today and organize\nas many tournaments as you want!",
                          style: AppTextStyles.kp20_700,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton1(
                text: "Save",
                onTap: () {
                  context.read<ConfigProvider>().buyPremium();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
