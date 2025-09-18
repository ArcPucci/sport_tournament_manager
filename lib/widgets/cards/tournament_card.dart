import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../../utils/utils.dart';
import '../dialogs/dialogs.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard({
    super.key,
    required this.tournament,
    this.onEdit,
    this.onDelete,
    this.onSelect,
  });

  final Tournament tournament;
  final VoidCallback? onSelect;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 358.w,
        decoration: BoxDecoration(
          color: AppColors.grey2,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  tournament.logo,
                  width: 66.r,
                  height: 66.r,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 228.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(tournament.name, style: AppTextStyles.kp20_700),
                          Text(
                            tournament.created.fullDate,
                            style: AppTextStyles.ts12_400,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: List.generate(
                          tournament.formats.length,
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
                                tournament.formats[index],
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
            SizedBox(height: 24.h),
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
                        Text(
                          "${tournament.teams.length}/10",
                          style: AppTextStyles.ts12_400,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text("Locations:", style: AppTextStyles.ts12_500),
                        SizedBox(width: 7.r),
                        Text(
                          "${tournament.locations.length}/10",
                          style: AppTextStyles.ts12_400,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onEdit,
                      child: Image.asset(
                        'assets/png/edit.png',
                        width: 24.r,
                        height: 24.r,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () => showDeleteDialog(context),
                      child: Image.asset(
                        'assets/png/trash.png',
                        width: 24.r,
                        height: 24.r,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: ConfirmationDialog(
            title: 'Are you sure you want to\ndelete the tournament?',
            onDelete: onDelete,
          ),
        );
      },
    );
  }
}
