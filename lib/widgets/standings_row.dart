import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../utils/utils.dart';

class StandingsRow extends StatelessWidget {
  const StandingsRow({
    super.key,
    required this.index,
    required this.standingData,
  });

  final int index;
  final StandingData standingData;

  @override
  Widget build(BuildContext context) {
    final isGreen = index == 1 && standingData.points > 0;
    return SizedBox(
      width: 355.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 33.w,
            child: Text(
              "$index",
              style: AppTextStyles.ts14_400.copyWith(
                decoration: TextDecoration.none,
                color: isGreen ? AppColors.green : null,
              ),
            ),
          ),
          SizedBox(
            width: 114.w,
            child: Center(
              child: Text(
                standingData.team,
                style: AppTextStyles.ts12_500.copyWith(
                  color: isGreen ? AppColors.green : null,
                ),
              ),
            ),
          ),
          ...List.generate(
            4,
            (index) => SizedBox(
              width: 19.w,
              child: Text(
                "${standingData.stats[index]}",
                style: AppTextStyles.ts12_500.copyWith(
                  color: isGreen ? AppColors.green : null,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 41.w,
            child: Text(
              "${standingData.pf}:${standingData.pa}",
              style: AppTextStyles.ts12_500.copyWith(
                color: isGreen ? AppColors.green : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
