import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

class MyselfCommand extends Command {
  @override
  final name = 'myself';

  @override
  final description = 'Returns details for the current user.';

  @override
  final usage = 'myself';

  @override
  Future<void> run() async {
    final user = await getMyself();

    stdout.writeJson(user);

    exit(0);
  }
}
