import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

class ShowCommand extends Command {
  @override
  String get name => 'show';

  @override
  String get description => 'Show details of an issue.';

  @override
  String get category => 'Issue';

  ShowCommand() {
    addIssueKeyOption(argParser);
  }

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    final issueKey = results.option('key');
    if (issueKey == null) {
      throw UsageException(
        'The issue key could not be determined. Please use the --key option.',
        usage,
      );
    }

    try {
      final issue = await getIssueByKey(issueKey);

      stdout.writeJson(issue.toPrintable());
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
