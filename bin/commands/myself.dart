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
    try {
      final user = await getMyself();

      stdout.writeln('${user.displayName} <${user.emailAddress}>');
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
