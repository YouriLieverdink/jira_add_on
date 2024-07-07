import 'package:deep_pick/deep_pick.dart';

class User {
  final String displayName;
  final String emailAddress;

  const User({
    required this.displayName,
    required this.emailAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: pick(json, 'displayName').asStringOrThrow(),
      emailAddress: pick(json, 'emailAddress').asStringOrThrow(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'emailAddress': emailAddress,
    };
  }
}
