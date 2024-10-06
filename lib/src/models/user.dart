import 'package:deep_pick/deep_pick.dart';

class User {
  final String accountId;
  final String displayName;
  final String emailAddress;

  const User({
    required this.accountId,
    required this.displayName,
    required this.emailAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accountId: pick(json, 'accountId').asStringOrThrow(),
      displayName: pick(json, 'displayName').asStringOrThrow(),
      emailAddress: pick(json, 'emailAddress').asStringOrThrow(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'displayName': displayName,
      'emailAddress': emailAddress,
    };
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer //
        .writeln('$displayName ($emailAddress)');

    return '$buffer';
  }
}
