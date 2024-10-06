import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

import './commands/build.dart';
import './commands/issue/show.dart';
import './commands/issue/worklog.dart';
import 'commands/time.dart';
import './commands/user/myself.dart';

Future<void> main(
  List<String> args,
) async {
  final runner = CommandRunner(
    'jira_add_on',
    'Command-line tool to interact with Jira.',
  );

  // User commands.
  runner.addCommand(UserMyselfCommand());

  // Issue commands.
  runner.addCommand(IssueShowCommand());
  runner.addCommand(IssueWorklogCommand());

  // Other commands.
  runner.addCommand(BuildCommand());
  runner.addCommand(TimeCommand());

  try {
    await runner.run(args);
  } //
  on UsageException catch (e) {
    stderr.writeln(e);
    exit(64);
  } //
  on DioException catch (e) {
    final response = e.response;
    if (response == null) {
      stderr.writeln('Failed to connect to the server.');
      exit(1);
    }

    switch (response.statusCode) {
      case 400:
        stderr.writeln('[400] Bad request. Please check the arguments.');
        exit(1);

      case 401:
        stderr.writeln('[401] Unauthorized.');
        exit(1);
    }
  } //
  finally {
    jiraClient.close();
  }
}
