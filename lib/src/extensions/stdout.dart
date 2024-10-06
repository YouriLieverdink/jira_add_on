import 'dart:convert';
import 'dart:io';
import 'dart:math';

final _encoder = JsonEncoder.withIndent(' ' * 4);

extension WriteLnJson on Stdout {
  /// Converts [object] to a String by invoking [JsonEncoder.convert(object)]
  /// and writes the result to `this`, followed by a newline.
  void writeJson([Object? object = ""]) {
    writeln(_encoder.convert(object));
  }
}

extension WriteLnTable on Stdout {
  /// Pretty prints a table using the provided [rows]. It also allows for values
  /// to include newlines, which will not be split into separate rows. The first
  /// rows is considered to be the header. Between every column, a divider is
  /// printed. The result is written to `this`.
  void writeTable(List<List<String>> rows) {
    final columnWidths = List<int>.filled(rows.first.length, 0);

    for (final row in rows) {
      for (var i = 0; i < row.length; i++) {
        columnWidths[i] = max(columnWidths[i], row[i].length);
      }
    }

    final divider = columnWidths.map((width) => '-' * (width + 2)).join('+');
    final dividerLine = '+$divider+';

    void printRow(List<String> row) {
      stdout.write('| ');
      for (var i = 0; i < row.length; i++) {
        stdout.write(row[i].padRight(columnWidths[i]));

        if (i < row.length - 1) {
          stdout.write(' | ');
        }
      }
      stdout.write(' |');
      stdout.writeln();
    }

    writeln(dividerLine);
    printRow(rows.first);
    writeln(dividerLine);

    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      printRow(row);
    }

    writeln(dividerLine);
  }
}
