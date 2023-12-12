import 'package:github_repo_commit_map/models/week_model.dart';

class CommitDataModel {
  late List<WeekModel> weeks;

  CommitDataModel({required this.weeks});

  CommitDataModel.fromJson(List<Map<String, dynamic>> jsonData) {
    weeks = [];

    for (var week in jsonData) {
      weeks.add(
        WeekModel(
          days: week[''],
          weekStart: week[''],
          totalCommit: week[''],
        ),
      );
    }
  }
}
