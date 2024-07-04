import 'dart:io';

import 'package:args/command_runner.dart';

import './commands/log.dart';

Future<void> main(
  List<String> args,
) async {
  final runner = CommandRunner(
    'worklog',
    'Command-line tool to log working hours on Jira.',
  );

  runner.addCommand(LogCommand());

  try {
    await runner.run(args);
  } //
  on UsageException catch (e) {
    print(e);
    exit(64);
  }
}
