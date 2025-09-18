import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/models/models.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  List<String> _formats = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentsProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            SizedBox(height: 12.h),
            CustomAppBar(title: "Your tournaments"),
            Expanded(child: _buildBody(context, value)),
          ],
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, TournamentsProvider value) {
    if (value.tournaments.isEmpty) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: Text("No tournaments yet", style: AppTextStyles.ts16_500),
            ),
          ),
          SafeArea(
            child: CustomButton1(
              text: "Create a tournament",
              onTap: () => context.push('/create'),
            ),
          ),
        ],
      );
    } else {
      final tournaments = getFilteredTournaments(value.tournaments);

      return Column(
        children: [
          SizedBox(height: 24.h),
          SizedBox(
            height: 38.h,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  tournamentFormats.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: SelectableCard(
                      text: tournamentFormats[index],
                      selected: _formats.contains(tournamentFormats[index]),
                      onSelect: () => _onSelectFormat(tournamentFormats[index]),
                    ),
                  ),
                ),
              ),
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
                    onSelect: () {
                      value.setTournament(tournaments[index]);
                      context.push('/tournament');
                    },

                    onEdit: () {
                      value.setTournament(tournaments[index]);
                      context.push('/edit');
                    },
                    onDelete: () => value.deleteTournament(tournaments[index]),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  List<Tournament> getFilteredTournaments(List<Tournament> tournaments) {
    if (_formats.isEmpty) return tournaments;

    final list = <Tournament>{};

    for (var item in tournaments) {
      for (var format in item.formats) {
        if (_formats.contains(format)) list.add(item);
      }
    }

    return list.toList();
  }

  void _onSelectFormat(String tournamentFormat) {
    if (_formats.contains(tournamentFormat)) {
      _formats.remove(tournamentFormat);
    } else {
      _formats.add(tournamentFormat);
    }
    setState(() {});
  }
}
