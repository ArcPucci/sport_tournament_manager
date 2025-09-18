import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../../utils/utils.dart';
import '../widgets.dart';

class CreatedMatchCard extends StatelessWidget {
  const CreatedMatchCard({
    super.key,
    required this.index,
    required this.match,
    this.onAddResult,
    this.onEdit,
    this.onDelete,
  });

  final int index;
  final GameMatch match;
  final VoidCallback? onAddResult;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      height: 190.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "${index + 1} game in the tournament",
                style: AppTextStyles.ts16_600,
              ),
              Spacer(),
              Image.asset(
                'assets/png/swap.png',
                width: 24.r,
                height: 24.r,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 8.w),
              CustomPopupMenu(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
          Container(
            width: 358.w,
            height: 140.h,
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/png/calendar.png',
                          width: 27.r,
                          height: 27.r,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          match.created!.fullDate3,
                          style: AppTextStyles.ts9_400,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/png/standings.png',
                          width: 27.r,
                          height: 27.r,
                          fit: BoxFit.fill,
                        ),
                        GestureDetector(
                          onTap: onAddResult,
                          child: Text(
                            "Enter the result",
                            style: AppTextStyles.ts9_400.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          'assets/png/location.png',
                          width: 27.r,
                          height: 27.r,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          match.location,
                          style: AppTextStyles.ts9_400,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                          style: AppTextStyles.ts14_400.copyWith(
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    Text("VS", style: AppTextStyles.kp20_700),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          match.secondTeam.isEmpty
                              ? "Choose team"
                              : match.secondTeam,
                          style: AppTextStyles.ts14_400.copyWith(
                            decoration: TextDecoration.none,
                          ),
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
