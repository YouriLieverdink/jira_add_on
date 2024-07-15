import 'package:deep_pick/deep_pick.dart';
import 'package:jira_add_on/jira_add_on.dart';

class IssueType {
  final String id;
  final String name;

  const IssueType({
    required this.id,
    required this.name,
  });

  factory IssueType.fromJson(Map<String, dynamic> json) {
    return IssueType(
      id: pick(json, 'id').asStringOrThrow(),
      name: pick(json, 'name').asStringOrThrow(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class IssueStatus {
  final String id;
  final String name;

  const IssueStatus({
    required this.id,
    required this.name,
  });

  factory IssueStatus.fromJson(Map<String, dynamic> json) {
    return IssueStatus(
      id: pick(json, 'id').asStringOrThrow(),
      name: pick(json, 'name').asStringOrThrow(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Issue {
  final String id;
  final String key;
  final Project project;
  final IssueType issuetype;
  final IssueStatus status;
  final String summary;

  String get url => 'https://$domain.atlassian.net/browse/$key';

  const Issue({
    required this.id,
    required this.key,
    required this.project,
    required this.issuetype,
    required this.status,
    required this.summary,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: pick(json, 'id').asStringOrThrow(),
      key: pick(json, 'key').asStringOrThrow(),
      project: Project.fromJson(
        pick(json, 'fields', 'project').asMapOrThrow(),
      ),
      issuetype: IssueType.fromJson(
        pick(json, 'fields', 'issuetype').asMapOrThrow(),
      ),
      status: IssueStatus.fromJson(
        pick(json, 'fields', 'status').asMapOrThrow(),
      ),
      summary: pick(json, 'fields', 'summary').asStringOrThrow(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'project': project.toJson(),
      'issuetype': issuetype.toJson(),
      'status': status.toJson(),
      'summary': summary,
    };
  }

  Map<String, dynamic> toPrintable() {
    return {
      'project': project.name,
      'type': issuetype.name,
      'issue': '$key : $summary',
      'status': status.name,
      'url': url,
    };
  }
}
