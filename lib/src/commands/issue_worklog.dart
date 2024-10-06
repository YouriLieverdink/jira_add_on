part of 'issue.dart';

class IssueWorklogCommand extends Command {
  @override
  String get name => 'worklog';

  @override
  String get description => 'Add a worklog to an issue.';

  @override
  String get category => 'Issue';

  @override
  String get invocation => '$name [timeSpent]';

  IssueWorklogCommand() {
    argParser.addOption(
      'comment',
      abbr: 'c',
      help: 'Additional comment for the worklog.',
    );
  }

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    final timeSpent = results.rest.join(' ');
    if (timeSpent.isEmpty) {
      throw UsageException(
        'Please specify the time spent on the issue.',
        usage,
      );
    }

    final issueKey = parent?.argResults?.option('key');
    if (issueKey == null) {
      throw UsageException(
        'Issue key could not be determined. Please use the --key option.',
        parent?.usage ?? usage,
      );
    }

    final comment = results.option('comment');

    try {
      final worklog = await postIssueByKeyWorklog(
        issueKey,
        WorklogForm(
          timeSpent: timeSpent,
          comment: comment,
        ),
      );

      stdout.writeJson(worklog);
      exit(0);
    } //
    on DioException catch (e) {
      final response = e.response;
      if (response == null) {
        stderr.writeln('Failed to connect to the server.');
        exit(1);
      }

      switch (response.statusCode) {
        case 404:
          stderr.writeln('[404] Issue with key: `$issueKey` not found.');
          exit(1);
      }

      rethrow;
    }
  }
}
