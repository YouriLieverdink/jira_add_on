import 'dart:io';

import 'package:dotenv/dotenv.dart';

final home = Platform.environment['HOME'];

final env = DotEnv(quiet: true)
  ..load([
    "$home/.config/jira_add_on/config",
    ".env",
  ]);

String get domain => env.getOrElse('DOMAIN', () => '');
String get baseUrl => 'https://$domain.atlassian.net/rest/api/latest';

String get username => env.getOrElse('USERNAME', () => 'admin');
String get password => env.getOrElse('PASSWORD', () => '');
