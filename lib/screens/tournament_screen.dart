import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/models/models.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

import '../providers/providers.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TournamentProvider(
          matchesService: Provider.of(context, listen: false),
          showMessage: (message) => showMessage(context, message),
          tournamentsProvider: Provider.of(context, listen: false),
        );
      },
      child: Consumer<TournamentProvider>(
        builder: (context, value, child) {
          final tournament = value.tournament;
          return Column(
            children: [
              SizedBox(height: 12.h),
              CustomAppBar(title: tournament.name),
              SizedBox(height: 24.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: List.generate(tournamentTabs.length, (index) {
                    final tab = tournamentTabs[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: TabCard(
                        tab: tab,
                        selected: value.tab == index,
                        onTap: () => value.setTab(index),
                      ),
                    );
                  }),
                ),
              ),
              Expanded(child: _buildBody(context, value)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, TournamentProvider value) =>
      switch (value.tab) {
        0 => _buildAbout(context, value),
        1 => _buildSchedule(context, value),
        2 => _buildStandings(context, value),
        3 => _buildStatistics(context, value),
        _ => SizedBox(),
      };

  Widget _buildAbout(BuildContext context, TournamentProvider value) {
    final tournament = value.tournament;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              children: [
                SizedBox(
                  width: 358.w,
                  child: Text("Tournament name", style: AppTextStyles.ts16_600),
                ),
                SizedBox(height: 16.h),
                ListTileItem(
                  canDelete: false,
                  name: tournament.name,
                  textStyle: AppTextStyles.ts16_400,
                  onEdit: () => showInputDialog(
                    context: context,
                    title: "Enter the tournament name",
                    onSave: value.changeTournamentName,
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: 358.w,
                  child: Text("Teams", style: AppTextStyles.ts16_600),
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tournament.teams.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.h);
                  },
                  itemBuilder: (context, index) {
                    final team = tournament.teams[index];
                    return Center(
                      child: ListTileItem(
                        name: team,
                        icon: 'assets/png/team_logo.png',
                        onEdit: () => showInputDialog(
                          context: context,
                          title: "Enter the team name",
                          onSave: (name) => value.editTeamName(index, name),
                        ),
                        onDelete: () => showConfirmationDialog(
                          context: context,
                          title: "Are you sure you want\nto delete this team?",
                          onDelete: () => value.deleteTeam(index),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: 358.w,
                  child: Text("Players", style: AppTextStyles.ts16_600),
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tournament.players.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.h);
                  },
                  itemBuilder: (context, index) {
                    final player = tournament.players[index];
                    return Center(
                      child: ListTileItem(
                        name: player,
                        icon: 'assets/png/player_logo.png',
                        onEdit: () => showInputDialog(
                          context: context,
                          title: "Enter the player name",
                          onSave: (name) => value.editPlayerName(index, name),
                        ),
                        onDelete: () => showConfirmationDialog(
                          context: context,
                          title:
                              "Are you sure you want\nto delete this player?",
                          onDelete: () => value.deletePlayer(index),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: 358.w,
                  child: Text("Locations", style: AppTextStyles.ts16_600),
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tournament.locations.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.h);
                  },
                  itemBuilder: (context, index) {
                    final locations = tournament.locations[index];
                    return Center(
                      child: ListTileItem(
                        name: locations,
                        icon: 'assets/png/location_logo.png',
                        onEdit: () => showInputDialog(
                          context: context,
                          title: "Enter the location name",
                          onSave: (name) => value.editLocationName(index, name),
                        ),
                        onDelete: () => showConfirmationDialog(
                          context: context,
                          title:
                              "Are you sure you want\nto delete this location?",
                          onDelete: () => value.deleteLocation(index),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        CustomButton1(
          text: 'Edit tournament',
          onTap: () async {
            final tournament = await context.push<Tournament>('/edit');
            if (tournament != null) {
              value.init(tournament);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSchedule(BuildContext context, TournamentProvider value) {
    final tournament = value.tournament;
    return Column(
      children: [
        SizedBox(height: 24.h),
        SizedBox(
          width: 358.w,
          child: Text("Choose a format", style: AppTextStyles.ts16_600),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 390.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(tournament.formats.length, (index) {
                final text = tournament.formats[index];
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: SelectableCard(
                    text: text,
                    selected: value.format == text,
                    onSelect: () => value.setFormat(text),
                  ),
                );
              }),
            ),
          ),
        ),
        value.matches.isEmpty
            ? Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 50.h),
                          child: Text(
                            "No matches created",
                            style: AppTextStyles.ts16_500,
                          ),
                        ),
                      ),
                    ),
                    CustomButton1(
                      text: 'Create a schedule',
                      onTap: () {
                        final matchesNumber = formatMap[value.format] ?? 2;
                        showSchedulesDialog(
                          context,
                          matchesNumber,
                          value.tournament,
                          value.saveMatches,
                        );
                      },
                    ),
                  ],
                ),
              )
            : Expanded(
                child: ListView.separated(
                  itemCount: value.matches.length,
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 24.h);
                  },
                  itemBuilder: (context, index) {
                    final match = value.matches[index];
                    return Center(
                      child: CreatedMatchCard(
                        index: index,
                        match: match,
                        onAddResult: () => showGameResultsSheet(
                          context,
                          match,
                          value.saveMatch,
                        ),
                        onEdit: () => showMatchSheet(
                          context,
                          match,
                          tournament,
                          value.saveMatch,
                        ),
                        onDelete: () => showConfirmationDialog(
                          context: context,
                          title: "Are you sure you want to\ndelete the match?",
                          onDelete: () => value.deleteMatch(match),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildStandings(BuildContext context, TournamentProvider value) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          SizedBox(
            width: 355.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 33.w,
                  child: Text(
                    "#",
                    style: AppTextStyles.ts14_400.copyWith(
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 114.w,
                  child: Center(
                    child: Text("Team", style: AppTextStyles.ts12_500),
                  ),
                ),
                SizedBox(
                  width: 19.w,
                  child: Text("P", style: AppTextStyles.ts12_500),
                ),
                SizedBox(
                  width: 19.w,
                  child: Text("W", style: AppTextStyles.ts12_500),
                ),
                SizedBox(
                  width: 19.w,
                  child: Text("T", style: AppTextStyles.ts12_500),
                ),
                SizedBox(
                  width: 19.w,
                  child: Text("L", style: AppTextStyles.ts12_500),
                ),
                SizedBox(
                  width: 41.w,
                  child: Text("PF/PA", style: AppTextStyles.ts12_500),
                ),
              ],
            ),
          ),
          ...List.generate(value.standingData.length, (index) {
            final data = value.standingData[index];
            return Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: StandingsRow(index: index + 1, standingData: data),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, TournamentProvider value) {
    if (value.matches.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100.h),
          child: Text(
            "No statistics yet.\nAdd matches to get them.",
            style: AppTextStyles.ts16_500,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: value.matches.length,
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h);
            },
            itemBuilder: (context, index) {
              final match = value.matches[index];
              final team1Stats = match.team1Stats;
              final team2Stats = match.team2Stats;

              final ssum1 = team1Stats.reduce(
                (value, element) => value + element,
              );
              final ssum2 = team2Stats.reduce(
                (value, element) => value + element,
              );

              final ssum = ssum1 + ssum2;

              final temp1 = team1Stats.getRange(4, team1Stats.length);
              final temp2 = team2Stats.getRange(4, team2Stats.length);

              final sum1 = temp1.reduce((value, element) => value + element);
              final sum2 = temp2.reduce((value, element) => value + element);

              final sum = sum1 + sum2;

              return Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/png/team_logo.png',
                        width: 37.r,
                        height: 37.r,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            match.firstTeam,
                            style: AppTextStyles.ts14_400.copyWith(
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      Text("VS", style: AppTextStyles.kp20_700),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              match.secondTeam,
                              style: AppTextStyles.ts14_400.copyWith(
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Image.asset(
                        'assets/png/team_logo.png',
                        width: 37.r,
                        height: 37.r,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Column(
                          children: List.generate(
                            ssum > 0
                                ? sum > 0
                                      ? team1Stats.length
                                      : 4
                                : 0,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      statsTexts[index],
                                      style: AppTextStyles.ts12_400,
                                    ),
                                    Text(
                                      team1Stats[index].toString(),
                                      style: AppTextStyles.ts12_400,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Column(
                          children: List.generate(
                            ssum > 0
                                ? sum > 0
                                      ? team2Stats.length
                                      : 4
                                : 0,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      statsTexts[index],
                                      style: AppTextStyles.ts12_400,
                                    ),
                                    Text(
                                      team2Stats[index].toString(),
                                      style: AppTextStyles.ts12_400,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        CustomButton1(
          text: "Add events",
          onTap: () =>
              showGameEventsSheet(context, value.matches, value.saveMatches),
        ),
      ],
    );
  }

  void showInputDialog({
    required BuildContext context,
    required String title,
    required void Function(String) onSave,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: EnterTextDialog(text: title, onSave: onSave),
        );
      },
    );
  }

  void showGameResultsSheet(
    BuildContext context,
    GameMatch match,
    void Function(GameMatch) onSave,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return GameResultSheet(match: match, onSave: onSave);
      },
    );
  }

  void showConfirmationDialog({
    required BuildContext context,
    required String title,
    VoidCallback? onDelete,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: ConfirmationDialog(title: title, onDelete: onDelete),
        );
      },
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void showSchedulesDialog(
    BuildContext context,
    int matchesNumber,
    Tournament tournament,
    void Function(List<GameMatch>) onSave,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: ScheduleTypesDialog(
            onSave: (type) {
              if (type == 0) {
                onSave.call([]);
                return;
              }
              showGamesSheet(context, matchesNumber, tournament, onSave);
            },
          ),
        );
      },
    );
  }

  void showGamesSheet(
    BuildContext context,
    int matchesNumber,
    Tournament tournament,
    void Function(List<GameMatch>) onSave,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return GamesSheet(
          matchesNumber: matchesNumber,
          tournament: tournament,
          onSave: onSave,
        );
      },
    );
  }

  void showMatchSheet(
    BuildContext context,
    GameMatch match,
    Tournament tournament,
    void Function(GameMatch) onSave,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return MatchSheet(match: match, tournament: tournament, onSave: onSave);
      },
    );
  }

  void showGameEventsSheet(
    BuildContext context,
    List<GameMatch> matches,
    void Function(List<GameMatch>) onSave,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return GameEventsSheet(matches: matches, onSave: onSave);
      },
    );
  }
}
