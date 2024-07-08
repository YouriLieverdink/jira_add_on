import 'dart:convert';
import 'dart:io';

final _encoder = JsonEncoder.withIndent(' ' * 4);

extension WriteLnJson on Stdout {
  /// Converts [object] to a String by invoking [JsonEncoder.convert(object)]
  /// and writes the result to `this`, followed by a newline.
  void writeJson([Object? object = ""]) {
    writeln(_encoder.convert(object));
  }
}
