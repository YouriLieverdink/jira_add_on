part of 'issue.dart';

class IssueShowCommand extends Command {
  @override
  String get name => 'show';

  @override
  String get description => 'Show details of an issue.';

  @override
  String get category => 'Issue';

  @override
  Future<void> run() async {
    final issueKey = parent?.argResults?.option('key');
    if (issueKey == null) {
      throw UsageException(
        'The issue key could not be determined. Please use the --key option.',
        parent?.usage ?? usage,
      );
    }

    try {
      final issue = await getIssueByKey(issueKey);

      stdout.write(issue);
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
