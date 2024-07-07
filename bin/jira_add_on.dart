import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:jira_add_on/jira_add_on.dart';

import './commands/log.dart';
import './commands/myself.dart';

Future<void> main(
  List<String> args,
) async {
  final runner = CommandRunner(
    'worklog',
    'Command-line tool to log working hours on Jira.',
  );

  runner.addCommand(LogCommand());
  runner.addCommand(MyselfCommand());

  try {
    await runner.run(args);
  } //
  on UsageException catch (e) {
    stderr.writeln(e);
    exit(64);
  } //
  finally {
    jiraClient.close();
  }
}
