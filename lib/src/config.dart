import 'dart:io';

import 'package:dotenv/dotenv.dart';

final home = Platform.environment['HOME'];

final env = DotEnv(quiet: true)
  ..load([
    "$home/.config/worklog/config",
    ".env",
  ]);

String get username => env['USERNAME'] ?? '';
String get password => env['PASSWORD'] ?? '';

String get baseUrl => 'https://script.atlassian.net/rest/api/latest';
