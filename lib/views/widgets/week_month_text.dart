import 'package:flutter/material.dart';

class WeekMonthText extends StatelessWidget {
  const WeekMonthText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
