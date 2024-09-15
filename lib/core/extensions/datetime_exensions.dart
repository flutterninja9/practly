extension DateTimeX on DateTime {
  DateTime get onlyDate {
    return DateTime(year, month, day);
  }

  String get isoCurrentDate {
    return "${onlyDate.toIso8601String()}Z";
  }
}
