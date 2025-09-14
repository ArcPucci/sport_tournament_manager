import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomBg(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (value) => setState(() => _selectedIndex = value),
              children: [_buildPage1(), _buildPage2(), _buildPage3()],
            ),
          ),
          Positioned(
            top: 24.h,
            right: 24.w,
            child: SafeArea(
              child: Image.asset(
                'assets/png/close.png',
                width: 34.r,
                height: 34.r,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: SafeArea(
              child: Container(
                width: 342.w,
                height: 68.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 1.sp,
                    color: Colors.white,
                    strokeAlign: 1,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: _prev,
                        child: Container(
                          width: 68.h,
                          height: 68.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: pi,
                            child: Image.asset(
                              'assets/png/arrow_right.png',
                              width: 37.r,
                              height: 37.r,
                              color: AppColors.red,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: _next,
                        child: Container(
                          width: 68.h,
                          height: 68.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.red,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/png/arrow_right.png',
                            width: 37.r,
                            height: 37.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    CustomPageIndicator(
                      selected: _selectedIndex,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage1() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image.asset('assets/png/onboarding2.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 80.h,
          left: 36.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Play by your\nown rules!", style: AppTextStyles.ro35_400),
              SizedBox(height: 16.h),
              Text(
                "Choose a format, create teams, add\nlocations, determine the winner,",
                style: AppTextStyles.ts16_400,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 93.h,
          child: SafeArea(
            child: Image.asset(
              'assets/png/comp1.png',
              width: 314.r,
              height: 455.r,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage2() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image.asset('assets/png/onboarding3.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 80.h,
          left: 36.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Build league\ntables", style: AppTextStyles.ro35_400),
              SizedBox(height: 16.h),
              Text(
                "Record the score and result\nof each game",
                style: AppTextStyles.ts16_400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPage3() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 80.h,
          left: 36.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Play by your\nown rules!", style: AppTextStyles.ro35_400),
              SizedBox(height: 16.h),
              Text(
                "Choose a format, create teams, add\nlocations, determine the winner,",
                style: AppTextStyles.ts16_400,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 93.h,
          child: SafeArea(
            child: Image.asset(
              'assets/png/comp2.png',
              width: 314.r,
              height: 455.r,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  void _prev() {
    if (_selectedIndex > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _next() {
    if (_selectedIndex < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
