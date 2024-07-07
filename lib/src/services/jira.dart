import 'dart:convert';

import 'package:jira_add_on/jira_add_on.dart';

Future<void> postIssueByKeyWorklog(
  String key,
  WorklogForm form,
) async {
  await jiraClient.post(
    '/issue/$key/worklog',
    data: jsonEncode(form),
  );
}

Future<User> getMyself() async {
  final response = await jiraClient.get(
    '/myself',
  );

  return User.fromJson(response.data);
}
