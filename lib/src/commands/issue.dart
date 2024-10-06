import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

part './issue_show.dart';
part './issue_worklog.dart';

class IssueCommand extends Command {
  IssueCommand() {
    final defaultsTo = (() {
      // Attempt to retrieve the key from the branch name.
      try {
        final branch = branchShowCurrent();
        final issueKey = getIssueKeyFromBranch(branch);

        return issueKey;
      } //
      catch (_) {
        return null;
      }
    })();

    argParser.addOption(
      'key',
      defaultsTo: defaultsTo,
      abbr: 'k',
      help: 'The key of the issue.',
    );

    addSubcommand(IssueShowCommand());
    addSubcommand(IssueWorklogCommand());
  }

  @override
  String get name => 'issue';

  @override
  String get description => 'Commands related to an issue.';
}
