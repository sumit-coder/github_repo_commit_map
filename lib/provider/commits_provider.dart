import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/api/github_api.dart';

class CommitsProvider with ChangeNotifier {
  final GitHubApi _gitHubApi = GitHubApi();

  // List<dynamic> get commitData => _commitData;

  Future<dynamic> getRepoCommitHistory(String userInput) async {
    // https://github.com/sumit-coder/help-me-design
    List<String> userInputStrings = userInput.replaceAll("https://github.com/", '').split('/');

    return await _gitHubApi.getCommitHistory(userName: userInputStrings[0], repositoryName: userInputStrings[1]);
  }
}
