import 'package:deep_pick/deep_pick.dart';
import 'package:jira_add_on/jira_add_on.dart';

class Worklog {
  final String id;
  final String issueKey;
  final String timeSpent;
  final String? comment;

  String get url =>
      'https://$domain.atlassian.net/browse/$issueKey?focusedWorklogId=$id';

  const Worklog({
    required this.id,
    required this.issueKey,
    required this.timeSpent,
    this.comment,
  });

  factory Worklog.fromJson(Map<String, dynamic> json) {
    return Worklog(
      id: pick(json, 'id').asStringOrThrow(),
      issueKey: pick(json, 'issueKey').asStringOrThrow(),
      timeSpent: pick(json, 'timeSpent').asStringOrThrow(),
      comment: pick(json, 'comment').asStringOrNull(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'issueKey': issueKey,
      'timeSpent': timeSpent,
      'comment': comment,
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
