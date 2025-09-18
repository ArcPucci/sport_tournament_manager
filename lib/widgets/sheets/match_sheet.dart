import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/models/models.dart';

import '../../utils/utils.dart';
import '../widgets.dart';

class MatchSheet extends StatefulWidget {
  const MatchSheet({
    super.key,
    required this.match,
    required this.onSave,
    required this.tournament,
  });

  final Tournament tournament;
  final GameMatch match;
  final void Function(GameMatch match) onSave;

  @override
  State<MatchSheet> createState() => _MatchSheetState();
}

class _MatchSheetState extends State<MatchSheet> {
  GameMatch _match = GameMatch.empty();

  @override
  void initState() {
    super.initState();
    _match = widget.match;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 390.w,
        height: 450.h,
        decoration: BoxDecoration(
          color: AppColors.black,
          border: Border(
            top: BorderSide(width: 1.sp, color: Colors.white),
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.only(top: 27.h),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              MatchCard(
                index: 1,
                match: _match,
                chooseFirstTeam: () {
                  showListTileDialog(
                    context,
                    "Choose a team",
                    'assets/png/team_logo.png',
                    widget.tournament.teams,
                    (name) {
                      if (_match.secondTeam == name) {
                        showOverlayMessage(
                          "The first team can't be the same as the first team",
                        );
                        return;
                      }
                      setState(() => _match.firstTeam = name);
                    },
                  );
                },
                chooseSecondTeam: () {
                  showListTileDialog(
                    context,
                    "Choose a team",
                    'assets/png/team_logo.png',
                    widget.tournament.teams,
                    (name) {
                      if (_match.firstTeam == name) {
                        showOverlayMessage(
                          "The second team can't be the same as the first team",
                        );
                        return;
                      }
                      setState(() => _match.secondTeam = name);
                    },
                  );
                },
                chooseDate: () {
                  showCalendar(
                    context,
                    _match.created,
                    (date) => setState(() => _match.created = date),
                  );
                },
                chooseLocation: () {
                  showListTileDialog(
                    context,
                    "Choose a location",
                    'assets/png/location_logo.png',
                    widget.tournament.locations,
                    (name) => setState(() => _match.location = name),
                  );
                },
              ),
              CustomButton1(
                text: "Save",
                onTap: () {
                  if (!_match.canSave) {
                    showOverlayMessage("Please fill in all the fields");
                    return;
                  }
                  widget.onSave.call(_match);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalendar(
    BuildContext context,
    DateTime? initialDate,
    void Function(DateTime) onChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: IOSCalendarPicker(
            initialDate: initialDate,
            onChanged: onChanged,
          ),
        );
      },
    );
  }

  void showListTileDialog(
    BuildContext context,
    String title,
    String logo,
    List<String> options,
    void Function(String) onSave,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CustomListTileDialog(
            title: title,
            logo: logo,
            options: options,
            onSave: onSave,
          ),
        );
      },
    );
  }

  void showOverlayMessage(String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    final controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    entry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: const Color(0xFF323232),
                child: SafeArea(
                  top: false,
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    controller.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      await controller.reverse();
      entry.remove();
      controller.dispose();
    });
  }
}
