import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:jira_add_on/jira_add_on.dart';

class BuildCommand extends Command {
  @override
  String get name => 'build';

  @override
  String get description => 'Show details of the current build.';

  @override
  Future<void> run() async {
    final build = {
      'version': '0.8.0',
    };

    stdout.writeJson(build);
    exit(0);
  }
}
