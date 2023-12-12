import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GitHubApi {
  final String baseUrl = 'https://api.github.com/repos/';
  final String suffixUrl = '/stats/commit_activity';
  // 'https://api.github.com/repos/$owner/$repo/stats/commit_activity';

  dynamic getCommitHistory({required String userName, required String repositoryName}) async {
    final finalGetUrl = '$baseUrl$userName/$repositoryName$suffixUrl';

    print(finalGetUrl);

    var response = await http.get(Uri.parse(finalGetUrl));

    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      log(response.statusCode.toString());
      throw Exception('Failed to load commits');
    }
  }
}
