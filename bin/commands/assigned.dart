import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

class AssignedCommand extends Command {
  @override
  final name = 'assigned';

  @override
  final description = 'Gets all issues assigned to you.';

  @override
  final usage = 'assigned';

  @override
  Future<void> run() async {
    try {
      final issues = await search(
        'statusCategory != "Done" AND assignee = currentUser() ORDER BY status',
      );

      issues //
          .map((issue) => issue.toPrintable())
          .forEach(stdout.writeJson);
      exit(0);
    } //
    on DioException catch (e) {
      final response = e.response;
      if (response == null) {
        stderr.writeln('Failed to connect to the server.');
        exit(1);
      }

      switch (response.statusCode) {
        case 401:
          stderr.writeln('[401] Unauthorized.');
          exit(1);
      }
    }
  }
}