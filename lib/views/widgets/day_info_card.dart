import 'package:flutter/material.dart';
import 'package:github_repo_commit_map/provider/commits_provider.dart';
import 'package:github_repo_commit_map/utils/consts.dart';
import 'package:provider/provider.dart';

class DayInfoCard extends StatefulWidget {
  const DayInfoCard({super.key, required this.commitData});

  final List<dynamic> commitData;

  @override
  State<DayInfoCard> createState() => _DayInfoCardState();
}

class _DayInfoCardState extends State<DayInfoCard> {
  String commitsCount = '0';

  @override
  void initState() {
    var commitProvider = Provider.of<CommitsProvider>(context, listen: false);

    if (widget.commitData.isNotEmpty) {
      commitsCount = widget.commitData[commitProvider.activeWeekIdx]['days'][commitProvider.activeDayIdx];
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var commitProvider = Provider.of<CommitsProvider>(context);

    return Container(
      width: 300,
      height: 150,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoLabelAndBody(
                label: 'Commits',
                body: commitProvider.dayCommitCount.toString(),
              ),
              InfoLabelAndBody(
                label: 'Day',
                body: commitProvider.selectedDayDay.toString(),
              ),
              InfoLabelAndBody(
                label: 'Date',
                body: getNormalDateFormDateTime(commitProvider.selectedDayDate),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoLabelAndBody(
                label: 'week total',
                body: '24',
              ),
              InfoLabelAndBody(
                label: 'Week No',
                body: '51',
              ),
              InfoLabelAndBody(
                label: 'week',
                body: getNormalDateFormDateTime(commitProvider.weekStart),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoLabelAndBody extends StatelessWidget {
  const InfoLabelAndBody({super.key, required this.label, required this.body});

  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
        SizedBox(height: 4),
        Text(
          body,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade900,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
