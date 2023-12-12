import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/provider/commits_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/search_bar_card.dart';
import 'package:http/http.dart' as http;

class CommitHistoryScreen extends StatefulWidget {
  @override
  _CommitHistoryScreenState createState() => _CommitHistoryScreenState();
}

class _CommitHistoryScreenState extends State<CommitHistoryScreen> {
  final String owner = 'sumit-coder';
  final String repo = 'sumit-coder';
  late http.Response response;
  late List<dynamic> data = [];

  final TextEditingController searchTextController = TextEditingController(text: 'https://github.com/sumit-coder/sumit-coder');

  fetchCommits() async {
    response = await http.get(Uri.parse('https://api.github.com/repos/$owner/$repo/stats/commit_activity'));
    // https://github.com/sumit-coder/sumit-coder

    setState(() {});
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      setState(() {});
      // return data
      //     .map((commit) => {
      //           'sha': commit['sha'],
      //           'author': commit['commit']['author']['name'],
      //           'message': commit['commit']['message'],
      //         })
      //     .toList();
    } else {
      throw Exception('Failed to load commits');
    }
  }

  @override
  Widget build(BuildContext context) {
    var commitProvider = Provider.of<CommitsProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFF3D4042),
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            SearchBarCard(
              onTapSearch: () async {
                // fetchCommits();
                data = await commitProvider.getRepoCommitHistory(searchTextController.text);

                setState(() {});
              },
              searchInputController: searchTextController,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.amber,
                  width: 624,
                  height: 24,
                  child: Row(
                    children: [],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(-2, -2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  // width: double.maxFinite,
                  height: (12 * 7) + 16,
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      for (var i = 0; i < data.length; i++)
                        // HeatBox(
                        //   heatLevel: i,
                        // )
                        WeekColumn(
                          weekCommitByDays: data[i]['days'],
                        )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 100),
            FilledButton(
              onPressed: () {
                print(data);
              },
              child: Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}

class WeekColumn extends StatelessWidget {
  WeekColumn({
    super.key,
    required this.weekCommitByDays,
    // required this.weekData,
  });

  final List<dynamic> weekCommitByDays;
  // final Map<String, dynamic> weekData;

  // int totalCommits = weekData['total'];
  // String weekStart = DateTime.fromMillisecondsSinceEpoch(weekData['week'] * 1000).toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var day in weekCommitByDays)
            HeatBox(
              heatLevel: day,
            )
        ],
      ),
    );
  }
}

class HeatBox extends StatelessWidget {
  HeatBox({super.key, required this.heatLevel});

  final dynamic heatLevel;

  final Color l0Color = Colors.grey.shade900;
  final Color l1Color = const Color(0xFF0e4429);
  final Color l2Color = const Color(0xFF006d32);
  final Color l3Color = const Color(0xFF26a641);
  final Color l4Color = const Color(0xFF39d353);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(heatLevel);
        String weekStart = DateTime.fromMillisecondsSinceEpoch(1671321600 * 1000).toString();
        print(weekStart);
      },
      child: Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: heatLevel == 0
              ? l0Color
              : heatLevel == 1
                  ? l1Color
                  : heatLevel == 2
                      ? l2Color
                      : heatLevel == 3
                          ? l3Color
                          : l4Color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
