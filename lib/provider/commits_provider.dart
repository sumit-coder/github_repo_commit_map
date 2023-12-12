import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/api/github_api.dart';

class CommitsProvider with ChangeNotifier {
  final GitHubApi _gitHubApi = GitHubApi();

  getRepoCommitHistory(String userInput) async {
    // https://github.com/sumit-coder/help-me-design
    List<String> userInputStrings = userInput.replaceAll("https://github.com/", '').split('/');

    dynamic data = await _gitHubApi.getCommitHistory(userName: userInputStrings[0], repositoryName: userInputStrings[1]);

    print(data);
  }
}
