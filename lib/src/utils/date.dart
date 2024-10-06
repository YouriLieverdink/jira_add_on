import 'package:intl/intl.dart';

String _format(DateTime dateTime) {
  final formatter = DateFormat('yyyy-MM-dd');

  return formatter.format(dateTime);
}

(String, String) getToday() {
  final now = DateTime.now();

  return (_format(now), _format(now));
}

(String, String) getThisWeek() {
  final now = DateTime.now();

  return (
    _format(now.subtract(Duration(days: now.weekday - 1))),
    _format(now.add(Duration(days: 7 - now.weekday)))
  );
}

(String, String) getThisMonth() {
  final now = DateTime.now();

  return (
    _format(DateTime(now.year, now.month, 1)),
    _format(DateTime(now.year, now.month + 1, 0))
  );
}

(String, String) getLastWeek() {
  final now = DateTime.now();

  return (
    _format(now.subtract(Duration(days: now.weekday + 6))),
    _format(now.subtract(Duration(days: now.weekday)))
  );
}

(String, String) getLastMonth() {
  final now = DateTime.now();

  return (
    _format(DateTime(now.year, now.month - 1, 1)),
    _format(DateTime(now.year, now.month, 0))
  );
}
