import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';
import 'package:jira_add_on/src/services/git.dart';

class LogCommand extends Command {
  LogCommand() {
    argParser.addOption(
      'comment',
      abbr: 'c',
      help: 'Additional comment for the worklog.',
    );

    argParser.addOption(
      'key',
      abbr: 'k',
      help: 'The issue key to log work on.',
    );
  }

  @override
  final name = 'log';

  @override
  final description = 'Log work on an issue';

  @override
  final usage = 'jira_add_on log <timeSpent>';

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    final timeSpent = results.rest.join(' ');

    var issueKey = results.option('key');

    // When no issue key is provided, try to read from the current branch.
    if (issueKey == null) {
      final branch = branchShowCurrent();
      issueKey = getKeyFromBranch(branch);
    }

    if (issueKey == null) {
      throw UsageException(
        'Issue key could not be determined. Please use the --key option.',
        usage,
      );
    }

    try {
      final worklog = await postIssueByKeyWorklog(
        issueKey,
        WorklogForm(
          timeSpent: timeSpent,
          comment: results.option('comment'),
        ),
      );

      stdout.writeJson(worklog);

      exit(0);
    } //
    on DioException catch (e) {
      final response = e.response;
      if (response == null) {
        stderr.writeln('Failed to connect to the server.');
        exit(1);
      }

      switch (response.statusCode) {
        case 404:
          stderr.writeln('[404] Issue with key: `$issueKey` not found.');
          exit(1);
      }

      rethrow;
    }
  }
}
