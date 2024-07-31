import 'package:deep_pick/deep_pick.dart';
import 'package:jira_add_on/jira_add_on.dart';

class Worklog {
  final String id;
  final String? issueKey;
  final String timeSpent;
  final int timeSpentSeconds;
  final DateTime started;
  final String? comment;

  String get url =>
      'https://$domain.atlassian.net/browse/$issueKey?focusedWorklogId=$id';

  const Worklog({
    required this.id,
    this.issueKey,
    required this.timeSpent,
    required this.timeSpentSeconds,
    required this.started,
    this.comment,
  });

  factory Worklog.fromJson(Map<String, dynamic> json) {
    return Worklog(
      id: pick(json, 'id').asStringOrThrow(),
      issueKey: pick(json, 'issueKey').asStringOrNull(),
      timeSpent: pick(json, 'timeSpent').asStringOrThrow(),
      timeSpentSeconds: pick(json, 'timeSpentSeconds').asIntOrThrow(),
      started: pick(json, 'started').asDateTimeOrThrow(),
      comment: pick(json, 'comment').asStringOrNull(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'issueKey': issueKey,
      'timeSpent': timeSpent,
      'timeSpentSeconds': timeSpentSeconds,
      'comment': comment,
      'started': started.toIso8601String(),
      'url': url,
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
