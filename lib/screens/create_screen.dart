import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/models/tournament.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final TournamentsProvider _tournamentsProvider;

  @override
  void initState() {
    super.initState();
    _tournamentsProvider = Provider.of(context, listen: false);

    if (widget.isEdit) {
      final tournament = _tournamentsProvider.tournament;
      tournamentName.text = tournament.name;
      _logo = tournament.logo;
      _formats = tournament.formats;
      _players = tournament.players;
      _teams = tournament.teams;
    }
  }

  int _page = 0;

  String _logo = 'assets/png/logo3.png';

  final tournamentName = TextEditingController();

  List<String> _players = [];
  List<String> _teams = [];
  List<String> _locations = [];
  List<String> _formats = [];

  @override
  Widget build(BuildContext context) {
    final hasSave =
        _page == 0 ||
        (_page == 1 && _teams.isNotEmpty) ||
        (_page == 2 && _players.isNotEmpty) ||
        (_page == 3 && _locations.isNotEmpty);
    return Column(
      children: [
        SizedBox(height: 12.h),
        CustomAppBar(title: "Create a tournaments"),
        SizedBox(height: 14.h),
        SizedBox(
          width: 358.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tournament information", style: AppTextStyles.ts14_600),
              Text(
                "${_page + 1}/4",
                style: AppTextStyles.ts16_600.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              final isReached = index <= _page;
              return Container(
                width: 88.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isReached ? AppColors.red : AppColors.grey2,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(child: _buildPage()),
        if (hasSave)
          CustomButton1(text: _page == 3 ? 'Save' : 'Next', onTap: _next),
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      children: [
        Image.asset(_logo, width: 107.r, height: 107.r, fit: BoxFit.fill),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: showLogoSheet,
          child: Text("Change logo", style: AppTextStyles.ts14_400),
        ),
        SizedBox(height: 16.h),
        CustomInput1(controller: tournamentName),
        SizedBox(height: 24.h),
        SizedBox(
          width: 358.w,
          child: Text("Choose a format", style: AppTextStyles.ts16_600),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: 358.w,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.generate(
              tournamentFormats.length,
              (index) => SelectableCard(
                text: tournamentFormats[index],
                selected: _formats.contains(tournamentFormats[index]),
                onSelect: () => _onSelectFormat(tournamentFormats[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    if (_teams.isEmpty) return SizedBox();

    return Column(
      children: [
        ListView.separated(
          itemCount: _teams.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Center(
              child: ListTileItem(
                name: _teams[index],
                icon: 'assets/png/team_logo.png',
                onEdit: () => showInputDialog(
                  title: 'Enter the team name',
                  onSave: (value) => _editTeamName(index, value),
                ),
                onDelete: () => showConfirmationDialog(
                  title: 'Are you sure you want\nto delete the command?',
                  onDelete: () => _deleteTeam(index),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _addTeam,
              child: Text(
                "Add team",
                style: AppTextStyles.ts16_600.copyWith(
                  color: AppColors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    if (_players.isEmpty) return SizedBox();

    return Column(
      children: [
        ListView.separated(
          itemCount: _players.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Center(
              child: ListTileItem(
                name: _players[index],
                icon: 'assets/png/player_logo.png',
                onEdit: () => showInputDialog(
                  title: 'Enter the player name',
                  onSave: (value) => _editPlayerName(index, value),
                ),
                onDelete: () => showConfirmationDialog(
                  title: 'Are you sure you want\nto delete the player?',
                  onDelete: () => _deletePlayer(index),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _addPlayer,
              child: Text(
                "Add player",
                style: AppTextStyles.ts16_600.copyWith(
                  color: AppColors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep4() {
    if (_locations.isEmpty) return SizedBox();

    return Column(
      children: [
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Center(
              child: ListTileItem(
                name: _locations[index],
                icon: 'assets/png/location_logo.png',
                onEdit: () => showInputDialog(
                  title: 'Enter the location name',
                  onSave: (value) => _editLocationName(index, value),
                ),
                onDelete: () => showConfirmationDialog(
                  title: 'Are you sure you want\nto delete the location?',
                  onDelete: () => _deleteLocation(index),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _addLocation,
              child: Text(
                "Add location",
                style: AppTextStyles.ts16_600.copyWith(
                  color: AppColors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _next() {
    switch (_page) {
      case 0:
        if (tournamentName.text.trim().isEmpty) {
          showMessage('Please enter a tournament name');
          return;
        }

        if (_formats.isEmpty) {
          showMessage('Please select at least one format');
          return;
        }

        if (_teams.isEmpty) {
          showNumberPickerDialog(
            title: 'Enter the number of teams',
            onSave: (value) {
              for (var i = 0; i < value; i++) {
                _teams.add("Team ${i + 1}");
              }
              setState(() {});
            },
          );
        }
        break;
      case 1:
        if (_players.isEmpty) {
          showNumberPickerDialog(
            title: 'Enter the number of players',
            onSave: (value) {
              for (var i = 0; i < value; i++) {
                _players.add("Player ${i + 1}");
              }
              setState(() {});
            },
          );
        }
        break;
      case 2:
        if (_locations.isEmpty) {
          showNumberPickerDialog(
            title: 'Enter the number of locations',
            onSave: (value) {
              for (var i = 0; i < value; i++) {
                _locations.add("Location ${i + 1}");
              }
              setState(() {});
            },
          );
        }
        break;
      case 3:
        final id = widget.isEdit ? _tournamentsProvider.tournament.id : 0;

        final tournament = Tournament(
          id: id,
          name: tournamentName.text,
          logo: _logo,
          created: DateTime.now(),
          players: _players,
          teams: _teams,
          locations: _locations,
          formats: _formats,
        );

        if (widget.isEdit) {
          _tournamentsProvider.updateTournament(tournament);
        } else {
          _tournamentsProvider.createTournament(tournament);
        }
        break;
    }

    _page++;
    setState(() {});
  }

  void showLogoSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LogoSheet(
          logo: _logo,
          onSelected: (newLogo) {
            setState(() => _logo = newLogo);
          },
        );
      },
    );
  }

  void showInputDialog({
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

  void showConfirmationDialog({required String title, VoidCallback? onDelete}) {
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

  void showNumberPickerDialog({
    required String title,
    required void Function(int) onSave,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CustomNumberPickerDialog(title: title, onSave: onSave),
        );
      },
    );
  }

  Widget _buildPage() => switch (_page) {
    0 => _buildStep1(),
    1 => _buildStep2(),
    2 => _buildStep3(),
    3 => _buildStep4(),
    _ => SizedBox(),
  };

  void _onSelectFormat(String tournamentFormat) {
    if (_formats.contains(tournamentFormat)) {
      _formats.remove(tournamentFormat);
    } else {
      _formats.add(tournamentFormat);
    }

    setState(() {});
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _addTeam() {
    final value = 'Team ${_teams.length + 1}';
    _teams.add(value);
    setState(() {});
  }

  void _editTeamName(int index, String value) {
    if (value.trim().isEmpty) {
      showMessage('Team name must be not empty');
      return;
    }
    _teams[index] = value;
    setState(() {});
  }

  void _deleteTeam(int index) {
    if (_teams.length == 1) {
      showMessage('You must have at least one team');
      return;
    }
    _teams.removeAt(index);
    setState(() {});
  }

  void _addPlayer() {
    final value = 'Player ${_players.length + 1}';
    _players.add(value);
    setState(() {});
  }

  void _editPlayerName(int index, String value) {
    if (value.trim().isEmpty) {
      showMessage('Player name must be not empty');
      return;
    }

    _players[index] = value;
    setState(() {});
  }

  void _deletePlayer(int index) {
    if (_players.length == 1) {
      showMessage('You must have at least one player');
      return;
    }

    _players.removeAt(index);
    setState(() {});
  }

  void _addLocation() {
    final value = 'Location ${_locations.length + 1}';
    _locations.add(value);
    setState(() {});
  }

  void _editLocationName(int index, String value) {
    if (value.trim().isEmpty) {
      showMessage('Location name must be not empty');
      return;
    }
  }

  void _deleteLocation(int index) {
    if (_locations.length == 1) {
      showMessage('You must have at least one location');
      return;
    }
    _locations.removeAt(index);
    setState(() {});
  }
}
