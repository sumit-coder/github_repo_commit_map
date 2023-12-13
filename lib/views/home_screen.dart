import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:github_repo_commit_map/provider/commits_provider.dart';
import 'package:github_repo_commit_map/utils/utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widgets/day_info_card.dart';
import 'widgets/search_bar_card.dart';
import 'package:http/http.dart' as http;

import 'widgets/week_month_text.dart';

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

  // fetchCommits() async {
  //   response = await http.get(Uri.parse('https://api.github.com/repos/$owner/$repo/stats/commit_activity'));
  //   // https://github.com/sumit-coder/sumit-coder

  //   setState(() {});
  //   if (response.statusCode == 200) {
  //     data = json.decode(response.body);
  //     setState(() {});
  //     // return data
  //     //     .map((commit) => {
  //     //           'sha': commit['sha'],
  //     //           'author': commit['commit']['author']['name'],
  //     //           'message': commit['commit']['message'],
  //     //         })
  //     //     .toList();
  //   } else {
  //     throw Exception('Failed to load commits');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var commitProvider = Provider.of<CommitsProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color(0xFF3D4042),
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: const Color(0xFF121212),
              ),
              child: Text(
                "52 Week Commit Heat Map",
                style: GoogleFonts.dmSerifDisplay(
                  color: Colors.grey,
                  fontSize: 18,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 50),
            SearchBarCard(
              onTapSearch: () async {
                // fetchCommits();
                data = await commitProvider.getRepoCommitHistory(searchTextController.text);

                setState(() {});
              },
              searchInputController: searchTextController,
            ),
            const SizedBox(height: 60),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   // color: Colors.amber,
                  //   width: 624,
                  //   height: 44,
                  //   margin: const EdgeInsets.only(left: 44),
                  //   child: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       // for (var i = 0; i < 12; i++) Text('Jan'),
                  //       WeekMonthText(text: 'Week 52'),
                  //       // WeekMonthText(text: 'Feb'),
                  //       // WeekMonthText(text: 'Mar'),
                  //       // WeekMonthText(text: 'Apr'),
                  //       // WeekMonthText(text: 'May'),
                  //       // WeekMonthText(text: 'Jun'),
                  //       // WeekMonthText(text: 'Jul'),
                  //       // WeekMonthText(text: 'Aug'),
                  //       // WeekMonthText(text: 'Set'),
                  //       // WeekMonthText(text: 'Oct'),
                  //       // WeekMonthText(text: 'Nov'),
                  //       WeekMonthText(text: 'Week 1'),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: (12 * 7) + 16,
                      //   width: 44,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       WeekMonthText(text: 'Sun'),
                      //       WeekMonthText(text: 'Wed'),
                      //       WeekMonthText(text: 'Sat'),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(2, 2),
                              blurRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(-2, -2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        // width: double.maxFinite,
                        height: (12 * 7) + 16,
                        width: (12 * 52) + 16,
                        child: ListView.builder(
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // Get the maximum commit count using the reduce method
                            int maxCount = Utility.getMaxCommitCountOnSingleDay(data);
                            print(maxCount);

                            // print(Utility.normalizeCommitCounts(data, 1, 4, maxCount));
                            return WeekColumn(
                              weekIndex: index,
                              maxCommitCount: maxCount,
                              weekCommitByDays: data[index]['days'],
                            ).animate().fadeIn(delay: Duration(milliseconds: index * 20));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            DayInfoCard(
              commitData: data,
            ),
          ],
        ),
      ),
    );
  }
}

class WeekColumn extends StatelessWidget {
  const WeekColumn({
    super.key,
    required this.weekCommitByDays,
    required this.maxCommitCount,
    required this.weekIndex,
    // required this.weekData,
  });

  final List<dynamic> weekCommitByDays;
  final int maxCommitCount;
  final int weekIndex;

  // List<String> weekDays = [
  //   "Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday",
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var dayIdx = 0; dayIdx < weekCommitByDays.length; dayIdx++)
            HeatBox(
              dayIndex: dayIdx,
              weekIndex: weekIndex,
              commitCount: weekCommitByDays[dayIdx] as int,
              heatLevel: Utility.normalizeCommitCounts(weekCommitByDays[dayIdx], 1, 5, maxCommitCount),
            )
        ],
      ),
    );
  }
}

class HeatBox extends StatelessWidget {
  HeatBox({super.key, required this.heatLevel, required this.commitCount, required this.dayIndex, required this.weekIndex});

  final dynamic heatLevel;
  final int commitCount;
  final int dayIndex;
  final int weekIndex;

  final Color l0Color = Colors.grey.shade300;
  final Color l1Color = const Color(0xFF0e4429);
  final Color l2Color = const Color(0xFF006d32);
  final Color l3Color = const Color(0xFF26a641);
  final Color l4Color = const Color(0xFF39d353);

  @override
  Widget build(BuildContext context) {
    var commitProvider = Provider.of<CommitsProvider>(context);
    return InkWell(
      onTap: () {
        print("commitCount: $commitCount | heatLevel: $heatLevel");
        String weekStart = DateTime.fromMillisecondsSinceEpoch(1671321600 * 1000).toString();
        // DateTime weekStartDate = DateTime.fromMillisecondsSinceEpoch(1671321600 * 1000);
        // print(weekStartDate.add(Duration(days: weekDayIndex)));
        print(weekStart);

        commitProvider.onTapHeatMapDay(dayIdx: dayIndex, weekIdx: weekIndex);

        // print("currentDay: $commitCount | weekStartDate: ${weekStartDate.add(Duration(days: weekDayIndex))}");
      },
      child: Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.all(1),
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
