import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/api/github_api.dart';
import 'package:github_repo_commit_map/utils/consts.dart';

class CommitsProvider with ChangeNotifier {
  final GitHubApi _gitHubApi = GitHubApi();
  List<dynamic> commitsData = [];

  int activeDayIdx = 0;
  int activeWeekIdx = 0;
  // Selected Day Info
  int dayCommitCount = 0;
  int weekCommitTotal = 0;
  int weekNo = 1;

  String selectedDayDay = '';
  DateTime selectedDayDate = DateTime.now();
  DateTime weekStart = DateTime.now();

  // List<dynamic> get commitData => _commitData;

  Future<dynamic> getRepoCommitHistory(String userInput) async {
    // https://github.com/sumit-coder/help-me-design
    List<String> userInputStrings = userInput.replaceAll("https://github.com/", '').split('/');

    commitsData = await _gitHubApi.getCommitHistory(userName: userInputStrings[0], repositoryName: userInputStrings[1]);

    notifyListeners();
    return commitsData;
  }

  onTapHeatMapDay({required int dayIdx, required int weekIdx}) {
    activeDayIdx = dayIdx;
    activeWeekIdx = weekIdx;

    if (commitsData.isNotEmpty) {
      dayCommitCount = commitsData[weekIdx]['days'][dayIdx];
      weekCommitTotal = commitsData[weekIdx]['total'];
      weekNo = weekIdx + 1;
      weekStart = DateTime.fromMillisecondsSinceEpoch(commitsData[weekIdx]['week'] * 1000);
      selectedDayDate = weekStart.add(Duration(days: dayIdx));
      selectedDayDay = weekDays[selectedDayDate.weekday - 1];
    }
    print("$dayCommitCount | $weekCommitTotal | $weekStart | $selectedDayDate | $weekNo | $selectedDayDay");

    notifyListeners();
  }
}
