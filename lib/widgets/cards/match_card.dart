import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../../utils/utils.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    super.key,
    required this.index,
    required this.match,
    this.chooseFirstTeam,
    this.chooseSecondTeam,
    this.chooseDate,
    this.chooseLocation,
  });

  final int index;
  final GameMatch match;
  final VoidCallback? chooseFirstTeam;
  final VoidCallback? chooseSecondTeam;
  final VoidCallback? chooseDate;
  final VoidCallback? chooseLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358.w,
      height: 221.h,
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$index game in the tournament", style: AppTextStyles.ts16_600),
          SizedBox(height: 24.h),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: chooseFirstTeam,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/png/team_logo.png',
                              width: 37.r,
                              height: 37.r,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              match.firstTeam.isEmpty
                                  ? "Choose team"
                                  : match.firstTeam,
                              style: AppTextStyles.ts14_400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text("VS", style: AppTextStyles.kp20_700),
                    Expanded(
                      child: GestureDetector(
                        onTap: chooseSecondTeam,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              match.secondTeam.isEmpty
                                  ? "Choose team"
                                  : match.secondTeam,
                              style: AppTextStyles.ts14_400,
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              'assets/png/team_logo.png',
                              width: 37.r,
                              height: 37.r,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: chooseDate,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/png/calendar_logo.png',
                        width: 37.r,
                        height: 37.r,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        match.created != null
                            ? match.created!.fullDate2
                            : "Choose a date",
                        style: AppTextStyles.ts14_400,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: chooseLocation,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/png/location_logo_2.png',
                        width: 37.r,
                        height: 37.r,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        match.location.isEmpty
                            ? "Choose a location"
                            : match.location,
                        style: AppTextStyles.ts14_400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
