import 'package:args/command_runner.dart';
import 'package:deep_pick/deep_pick.dart';
import 'package:worklog/worklog.dart';

class LogCommand extends Command {
  LogCommand() {
    argParser.addOption(
      'comment',
      abbr: 'c',
      help: 'Additional comment for the worklog.',
    );
  }

  @override
  final name = 'log';

  @override
  final description = 'Log work on an issue';

  @override
  final usage = 'worklog log <issueKey> <timeSpent>';

  @override
  Future<void> run() async {
    final results = argResults;
    if (results == null) return;

    // Validate that the command has been called correctly.
    if (results.rest.length != 2) {
      throw UsageException(
        'Invalid number of arguments',
        usage,
      );
    }

    final issueKey = pick(results.rest, 0).asStringOrThrow();
    final timeSpent = pick(results.rest, 1).asStringOrThrow();

    await postIssueByKeyWorklog(
      issueKey,
      WorklogForm(
        timeSpent: timeSpent,
        comment: results.option('comment'),
      ),
    );
  }
}
