import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

class LogCommand extends Command {
  LogCommand() {
    argParser.addOption(
      'comment',
      abbr: 'c',
      help: 'Additional comment for the worklog.',
    );
  }

  @override
  final name = 'log';

  @override
  final description = 'Log work on an issue';

  @override
  final usage = 'jira_add_on log <issueKey> <timeSpent>';

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    // Validate that the command has been called correctly.
    if (results.rest.length != 2) {
      throw UsageException(
        'Invalid number of arguments',
        usage,
      );
    }

    final issueKey = pick(results.rest, 0).asStringOrThrow();
    final timeSpent = pick(results.rest, 1).asStringOrThrow();

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
