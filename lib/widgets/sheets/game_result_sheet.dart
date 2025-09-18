import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../../utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class GameResultSheet extends StatefulWidget {
  const GameResultSheet({super.key, required this.match, required this.onSave});

  final GameMatch match;
  final void Function(GameMatch match) onSave;

  @override
  State<GameResultSheet> createState() => _GameResultSheetState();
}

class _GameResultSheetState extends State<GameResultSheet> {
  GameMatch _gameMatch = GameMatch.empty();

  @override
  void initState() {
    super.initState();
    _gameMatch = widget.match;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 390.w,
        height: 560.h,
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  child: Column(
                    children: [
                      TeamStats(
                        team: _gameMatch.firstTeam,
                        stats: _gameMatch.team1Stats.take(4).toList(),
                        onIncrease: (index) {
                          if (_gameMatch.team1Stats[index] == 10) return;
                          _gameMatch.team1Stats[index]++;
                          setState(() {});
                        },
                        onDecrease: (index) {
                          if (_gameMatch.team1Stats[index] == 0) return;
                          _gameMatch.team1Stats[index]--;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 24.h),
                      TeamStats(
                        team: _gameMatch.secondTeam,
                        stats: _gameMatch.team2Stats.take(4).toList(),
                        onIncrease: (index) {
                          if (_gameMatch.team2Stats[index] == 10) return;
                          _gameMatch.team2Stats[index]++;
                          setState(() {});
                        },
                        onDecrease: (index) {
                          if (_gameMatch.team2Stats[index] == 0) return;
                          _gameMatch.team2Stats[index]--;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton1(
                text: "Save",
                onTap: () {
                  widget.onSave.call(_gameMatch);
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
