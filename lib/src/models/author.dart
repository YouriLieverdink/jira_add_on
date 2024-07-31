import 'package:deep_pick/deep_pick.dart';

class Author {
  final String accountId;

  const Author({
    required this.accountId,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      accountId: pick(json, 'accountId').asStringOrThrow(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
    };
  }
}
