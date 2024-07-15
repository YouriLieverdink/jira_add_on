import 'dart:io';

String branchShowCurrent() {
  final result = Process.runSync('git', ['branch', '--show-current']);
  if (result.exitCode != 0) {
    throw Exception('Failed to get current branch');
  }

  return result //
      .stdout
      .toString()
      .trim();
}
