import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

part './issue_show.dart';
part './issue_worklog.dart';

class IssueCommand extends Command {
  IssueCommand() {
    addSubcommand(IssueShowCommand());
    addSubcommand(IssueWorklogCommand());
  }

  @override
  String get name => 'issue';

  @override
  String get description => 'Commands related to an issue.';
}
