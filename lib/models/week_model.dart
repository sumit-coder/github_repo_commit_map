import 'package:github_repo_commit_map/models/day_model.dart';

class WeekModel {
  final List<DayModel> days;
  final int weekStart;
  final int totalCommit;

  WeekModel({
    required this.days,
    required this.weekStart,
    required this.totalCommit,
  });
}
