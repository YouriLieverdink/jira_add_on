import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:worklog/worklog.dart';

final _options = BaseOptions(
  baseUrl: baseUrl,
  headers: {
    'Authorization': basicAuthentication(username, password),
    'Content-Type': 'application/json',
  },
);

final _client = Dio(_options);

Future<void> postIssueByKeyWorklog(
  String key,
  WorklogForm form,
) async {
  await _client.post(
    '/issue/$key/worklog',
    data: jsonEncode(form),
  );
}
