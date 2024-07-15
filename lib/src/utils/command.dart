import 'package:args/args.dart';
import 'package:jira_add_on/jira_add_on.dart';

void addIssueKeyOption(
  ArgParser argParser,
) {
  final defaultsTo = (() {
    // Attempt to retrieve the key from the branch name.
    final branch = branchShowCurrent();
    final issueKey = getIssueKeyFromBranch(branch);

    return issueKey;
  })();

  argParser.addOption(
    'key',
    defaultsTo: defaultsTo,
    abbr: 'k',
    help: 'The key of the issue.',
  );
}
