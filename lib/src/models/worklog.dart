import 'package:deep_pick/deep_pick.dart';

class Worklog {
  final String id;
  final String timeSpent;
  final String? comment;

  const Worklog({
    required this.id,
    required this.timeSpent,
    this.comment,
  });

  factory Worklog.fromJson(Map<String, dynamic> json) {
    return Worklog(
      id: pick(json, 'id').asStringOrThrow(),
      timeSpent: pick(json, 'timeSpent').asStringOrThrow(),
      comment: pick(json, 'comment').asStringOrNull(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeSpent': timeSpent,
      'comment': comment,
    };
  }
}

class WorklogForm {
  final String timeSpent;
  final String? comment;

  const WorklogForm({
    required this.timeSpent,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'timeSpent': timeSpent,
      'comment': comment,
    };
  }
}
