import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:jira_add_on/jira_add_on.dart';

class TimeCommand extends Command {
  @override
  String get name => 'time';

  @override
  String get description => 'Show worked time.';

  @override
  Future<void> run() async {
    final start = '2024-09-30';
    final end = '2024-10-06';
    // final start = '2024-10-06';
    // final end = '2024-10-06';

    // 1. Get the current user.
    final myself = await getMyself();

    // 2. Search for issues with worklogs in a specific date range.
    final jql = """
      worklogAuthor = ${myself.accountId} AND 
      worklogDate >= $start AND
      worklogDate <= $end
    """;

    final issues = await search(jql);

    // 3. Get worklogs for each issue.
    final futures = issues.map((issue) => getWorklogByIssueKey(issue.key));
    final worklogs = (await Future.wait(futures)) //
        .expand((el) => el)
        .toList();

    // 4. Filter out worklogs outside the date range and that don't belong to the current user.
    final filtered = worklogs.where((worklog) {
      final date = worklog.started.toLocal();

      return date.isAfter(DateTime.parse(start)) &&
          date.isBefore(DateTime.parse(end).add(const Duration(days: 1))) &&
          worklog.author.accountId == myself.accountId;
    }).toList();

    // 5. Print out the total time spent per issue.
    for (final issue in issues) {
      final total = filtered
          .where((worklog) => worklog.issueKey == issue.key)
          .map((worklog) => worklog.timeSpentSeconds)
          .reduce((a, b) => a + b);

      final hours = total ~/ 3600;
      final minutes = (total % 3600) ~/ 60;

      stdout.writeln('${issue.key} (${issue.summary}): ${hours}h ${minutes}m');
    }

    // 6. Print out the total time spent.
    final totalTimeSpentSeconds = filtered
        .map((worklog) => worklog.timeSpentSeconds)
        .reduce((a, b) => a + b);

    final hours = totalTimeSpentSeconds ~/ 3600;
    final minutes = (totalTimeSpentSeconds % 3600) ~/ 60;

    stdout.writeln('Total: ${hours}h ${minutes}m');
  }
}
