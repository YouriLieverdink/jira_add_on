import 'dart:convert';

String basicAuthentication(
  String username,
  String password,
) {
  final encoded = utf8.encode('$username:$password');

  return 'Basic ${base64.encode(encoded)}';
}
