import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:jira_add_on/jira_add_on.dart';

class TodayCommand extends Command {
  @override
  String get name => 'today';

  @override
  String get description => 'Time worked today.';

  @override
  String get category => 'Time';

  @override
  Future<void> run() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    final since = midnight.millisecondsSinceEpoch;
    final ids = await getWorklogUpdatedIds(since);

    final worklogs = await getWorklogList(ids);

    final totalTimeSpentSeconds = worklogs
        .map((worklog) => worklog.timeSpentSeconds)
        .reduce((a, b) => a + b);

    final hours = totalTimeSpentSeconds ~/ 3600;
    final minutes = (totalTimeSpentSeconds % 3600) ~/ 60;

    stdout.writeln('${hours}h ${minutes}m');
    exit(0);
  }
}
