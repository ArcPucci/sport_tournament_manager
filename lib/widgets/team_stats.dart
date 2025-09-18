import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

import '../utils/utils.dart';

class TeamStats extends StatelessWidget {
  TeamStats({
    super.key,
    required this.team,
    required this.stats,
    required this.onIncrease,
    required this.onDecrease,
  });

  final String team;
  final List<int> stats;
  final void Function(int index) onIncrease;
  final void Function(int index) onDecrease;

  final list = ["Games Played (P)", "Wins (W)", "Ties (T)", "Losses (L)"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      child: Column(
        children: [
          Text(team, style: AppTextStyles.ts16_600),
          ...List.generate(stats.length, (index) {
            return Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: CounterWidget(
                title: list[index],
                value: stats[index],
                onIncrease: () => onIncrease.call(index),
                onDecrease: () => onDecrease.call(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}
