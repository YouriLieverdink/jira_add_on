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

  return Worklog.fromJson(response.data);
}

Future<User> getMyself() async {
  final response = await jiraClient.get(
    '/myself',
  );

  return User.fromJson(response.data);
}
