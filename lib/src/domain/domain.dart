import 'package:dio/dio.dart';
import 'package:jira_add_on/jira_add_on.dart';

final _options = BaseOptions(
  baseUrl: baseUrl,
  headers: {
    'Authorization': basicAuthentication(username, password),
    'Content-Type': 'application/json',
  },
);

final jiraClient = Dio(_options);
