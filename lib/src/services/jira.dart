import 'dart:convert';

import 'package:jira_add_on/jira_add_on.dart';

Future<Worklog> postIssueByKeyWorklog(
  String key,
  WorklogForm form,
) async {
  final response = await jiraClient.post(
    '/issue/$key/worklog',
    data: jsonEncode(form),
  );

  return Worklog.fromJson({
    ...response.data,
    'issueKey': key,
  });
}

Future<Issue> getIssueByKey(
  String key,
) async {
  final response = await jiraClient.get(
    '/issue/$key',
  );

  return Issue.fromJson(response.data);
}

Future<User> getMyself() async {
  final response = await jiraClient.get(
    '/myself',
  );

  return User.fromJson(response.data);
}

Future<List<Issue>> search(
  String jql,
) async {
  final response = await jiraClient.get(
    '/search',
    queryParameters: {
      'jql': jql,
    },
  );

  return (response.data['issues'] as List)
      .map((issue) => Issue.fromJson(issue))
      .toList();
}

String? getIssueKeyFromBranch(
  String branch,
) {
  final match = RegExp(r'[A-Z]+-\d+').firstMatch(branch);

  return match?.group(0);
}
