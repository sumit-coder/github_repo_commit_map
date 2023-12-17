import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/utils/consts.dart';
import 'package:http/http.dart' as http;

class GitHubApi {
  final String baseUrl = 'https://api.github.com/repos/';
  final String suffixUrl = '/stats/commit_activity';
  // 'https://api.github.com/repos/$owner/$repo/stats/commit_activity';

  Future<dynamic> getCommitHistory({required String userName, required String repositoryName}) async {
    final finalGetUrl = '$baseUrl$userName/$repositoryName$suffixUrl';

    http.Response response = await http.get(Uri.parse(finalGetUrl));

    var data = await json.decode(response.body);

    log(data.toString());
    // return data;

    if (response.statusCode == 200) {
      return data;
    } else {
      log(response.statusCode.toString());
      Exception('Failed to load commits');
      ScaffoldMessenger.of(navigatorContextKey.currentContext!).showSnackBar(SnackBar(content: Text("Failed to load commits")));
      return [];
    }
  }
}
