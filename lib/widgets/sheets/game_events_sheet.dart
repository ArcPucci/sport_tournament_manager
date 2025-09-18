import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import '../widgets.dart';

class GameEventsSheet extends StatefulWidget {
  const GameEventsSheet({
    super.key,
    required this.matches,
    required this.onSave,
  });

  final List<GameMatch> matches;
  final void Function(List<GameMatch>) onSave;

  @override
  State<GameEventsSheet> createState() => _GameEventsSheetState();
}

class _GameEventsSheetState extends State<GameEventsSheet> {
  List<GameMatch> _gameMatches = [];

  @override
  void initState() {
    super.initState();
    _gameMatches = List.from(widget.matches);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 390.w,
        height: 640.h,
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
                      "Adding games to a tournament",
                      style: AppTextStyles.ts16_600,
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
              Expanded(
                child: ListView.separated(
                  itemCount: _gameMatches.length,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  separatorBuilder: (context, index) => SizedBox(height: 60.h),
                  itemBuilder: (context, index) {
                    final gameMatch = _gameMatches[index];
                    final start = 4;
                    final end = gameMatch.team1Stats.length;
                    return Column(
                      children: [
                        TeamStats2(
                          team: gameMatch.firstTeam,
                          stats: gameMatch.team1Stats
                              .getRange(start, end)
                              .toList(),
                          onIncrease: (index) {
                            if (gameMatch.team1Stats[index + 4] == 300) return;
                            gameMatch.team1Stats[index + 4]++;
                            setState(() {});
                          },
                          onDecrease: (index) {
                            if (gameMatch.team1Stats[index + 4] == 0) return;
                            gameMatch.team1Stats[index + 4]--;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 24.h),
                        TeamStats2(
                          team: gameMatch.secondTeam,
                          stats: gameMatch.team2Stats
                              .getRange(start, end)
                              .toList(),
                          onIncrease: (index) {
                            if (gameMatch.team2Stats[index + 4] == 300) return;
                            gameMatch.team2Stats[index + 4]++;
                            setState(() {});
                          },
                          onDecrease: (index) {
                            if (gameMatch.team2Stats[index + 4] == 0) return;
                            gameMatch.team2Stats[index + 4]--;
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              CustomButton1(
                text: "Save",
                onTap: () {
                  widget.onSave.call(_gameMatches);
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
