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
