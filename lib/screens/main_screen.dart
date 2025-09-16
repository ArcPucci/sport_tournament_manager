import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/models/models.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = TextEditingController();

  Timer? _debounce;

  bool _upcoming = true;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentsProvider>(
      builder: (context, value, child) {
        final tournaments = getFilteredTournaments(value.tournaments);

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
            BannerWidget(),
            SizedBox(height: 16.h),
            CustomSearchBox(controller: controller),
            SizedBox(height: 16.h),
            SizedBox(
              width: 358.w,
              child: Row(
                children: [
                  Text("My tournaments", style: AppTextStyles.kp20_700),
                  Spacer(),
                  Text("Filter by:", style: AppTextStyles.ts16_400),
                  SizedBox(width: 8.r),
                  GestureDetector(
                    onTap: _updateFilter,
                    child: Text(
                      _upcoming ? "Upcoming" : "Past",
                      style: AppTextStyles.ts16_600.copyWith(
                        color: AppColors.red,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: tournaments.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  return Center(
                    child: TournamentCard(
                      tournament: tournaments[index],
                      onEdit: () {
                        value.setTournament(tournaments[index]);
                        context.go('/edit');
                      },
                      onDelete: () =>
                          value.deleteTournament(tournaments[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateFilter() {
    _upcoming = !_upcoming;
    setState(() {});
  }

  List<Tournament> getFilteredTournaments(List<Tournament> tournaments) {
    if (controller.text.isNotEmpty) {
      final query = controller.text.toLowerCase();

      return tournaments
          .where((e) => e.name.toLowerCase().contains(query))
          .toList();
    }

    final currentDate = DateTime.now();
    if (_upcoming) {
      return tournaments
          .where((tournament) => tournament.created.isAfter(currentDate))
          .toList();
    } else {
      return tournaments
          .where((tournament) => tournament.created.isBefore(currentDate))
          .toList();
    }
  }
}
