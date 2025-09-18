import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBg(
      bg: 'assets/png/onboarding1.png',
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 24.h,
            right: 24.w,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => context.go("/"),
                child: Image.asset(
                  'assets/png/close.png',
                  width: 34.r,
                  height: 34.r,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 130.h,
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    "Create your own\ntournament!",
                    style: AppTextStyles.ro35_400,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Create tournaments, fill in the results,\ndetermine the winner",
                    style: AppTextStyles.ts16_400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: SafeArea(
              child: CustomButton1(
                text: "Let's get started!",
                onTap: () => context.go('/onboarding'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
