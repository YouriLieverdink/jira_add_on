import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:jira_add_on/jira_add_on.dart';
import 'package:jira_add_on/src/utils/date.dart';

class TimeCommand extends Command {
  /// The available date range options.
  static final ranges = {
    'today': getToday,
    'thisWeek': getThisWeek,
    'thisMonth': getThisMonth,
    'lastWeek': getLastWeek,
    'lastMonth': getLastMonth,
  };

  TimeCommand() {
    argParser.addOption(
      'range',
      abbr: 'r',
      allowed: [...ranges.keys],
      defaultsTo: 'today',
      help: 'The range of time to search for worklogs.',
    );
  }

  @override
  String get name => 'time';

  @override
  String get description => 'Show time spent on issues.';

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    final range = results.option('range');
    if (range == null) {
      throw UsageException(
        'The range could not be determined. Please use the --range option.',
        usage,
      );
    }

    // 1. Determine the start and end date for the range.
    final (start, end) = ranges[range]!();

    // 2. Get the current user.
    final myself = await getMyself();

    // 3. Search for issues with worklogs in a specific date range.
    final jql = """
      worklogAuthor = ${myself.accountId} AND 
      worklogDate >= $start AND
      worklogDate <= $end
    """;

    final issues = await search(jql);

    // 4. Get worklogs for each issue.
    final futures = issues.map((issue) => getWorklogByIssueKey(issue.key));
    final worklogs = (await Future.wait(futures)) //
        .expand((el) => el)
        .toList();

    // 5. Filter out worklogs outside the date range and that don't belong to the current user.
    final filtered = worklogs.where((worklog) {
      final date = worklog.started.toLocal();

      return date.isAfter(DateTime.parse(start)) &&
          date.isBefore(DateTime.parse(end).add(const Duration(days: 1))) &&
          worklog.author.accountId == myself.accountId;
    }).toList();

    // 6. Print out the total time spent per issue.
    for (final issue in issues) {
      final total = filtered
          .where((worklog) => worklog.issueKey == issue.key)
          .map((worklog) => worklog.timeSpentSeconds)
          .reduce((a, b) => a + b);

      final hours = total ~/ 3600;
      final minutes = (total % 3600) ~/ 60;

      stdout.writeln('${issue.key} (${issue.summary}): ${hours}h ${minutes}m');
    }

    // 7. Print out the total time spent.
    final totalTimeSpentSeconds = filtered
        .map((worklog) => worklog.timeSpentSeconds)
        .reduce((a, b) => a + b);

    final hours = totalTimeSpentSeconds ~/ 3600;
    final minutes = (totalTimeSpentSeconds % 3600) ~/ 60;

    stdout.writeln('Total: ${hours}h ${minutes}m');
  }
}
