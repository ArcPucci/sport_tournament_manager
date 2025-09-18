class StandingData {
  String team;
  int pf;
  int pa;
  List<int> stats;

  int get points => stats[1] * 3 + stats[2];

  StandingData({
    required this.team,
    required this.pf,
    required this.pa,
    required this.stats,
  });
}
