import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:jira_add_on/jira_add_on.dart';

class MyselfCommand extends Command {
  @override
  String get name => 'myself';

  @override
  String get description => 'Show details of the current user.';

  @override
  String get category => 'User';

  @override
  Future<void> run() async {
    final user = await getMyself();

    stdout.writeJson(user.toPrintable());
    exit(0);
  }
}
