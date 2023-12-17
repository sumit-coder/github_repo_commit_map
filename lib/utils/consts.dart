import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorContextKey = GlobalKey<NavigatorState>();

final List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

String getNormalDateFormDateTime(DateTime dateTime) {
  return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
}
