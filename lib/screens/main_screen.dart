import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.h),
        SizedBox(
          width: 358.w,
          height: 25.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: Image.asset(
                  'assets/png/profile.png',
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 0,
                child: Image.asset(
                  'assets/png/notification.png',
                  width: 25.r,
                  height: 25.r,
                  fit: BoxFit.fill,
                ),
              ),
              Text("Welcome to the game!", style: AppTextStyles.ts16_600),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Image.asset(
          'assets/png/banner1.png',
          width: 359.r,
          height: 240.r,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 12.h),
        CustomPageIndicator(
          selected: 0,
          activeColor: AppColors.grey,
          inactiveColor: AppColors.darkGrey,
        ),
        SizedBox(height: 16.h),
        CustomSearchBox(),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Row(
            children: [
              Text("My tournaments", style: AppTextStyles.kp20_700),
              Spacer(),
              Text("Filter by:", style: AppTextStyles.ts16_400),
              SizedBox(width: 8.r),
              Text(
                "Upcoming",
                style: AppTextStyles.ts16_600.copyWith(
                  color: AppColors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.red,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              return Center(child: TournamentCard());
            },
          ),
        ),
      ],
    );
  }
}
