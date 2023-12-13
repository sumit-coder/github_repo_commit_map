final List<String> weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

String getNormalDateFormDateTime(DateTime dateTime) {
  return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
}
