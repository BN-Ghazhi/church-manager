import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// CSV export.
///
/// Writes to the user's Documents folder and returns the path, so the caller can
/// tell them exactly where the file went rather than leaving them to hunt for it.
class CsvExport {
  const CsvExport._();

  /// Escapes a single cell. Anything containing a comma, quote or newline is
  /// quoted, and embedded quotes are doubled — the rules spreadsheet software
  /// actually expects.
  static String _cell(Object? value) {
    final text = value?.toString() ?? '';
    if (text.contains(RegExp(r'[",\n\r]'))) {
      return '"${text.replaceAll('"', '""')}"';
    }
    return text;
  }

  static String buildCsv({
    required List<String> headers,
    required List<List<Object?>> rows,
  }) {
    final buffer = StringBuffer()
      ..writeln(headers.map(_cell).join(','));
    for (final row in rows) {
      buffer.writeln(row.map(_cell).join(','));
    }
    return buffer.toString();
  }

  /// Writes [content] to `<Documents>/<name>-<date>.csv` and returns the path.
  ///
  /// Returns null on web, where writing to the filesystem is not available and
  /// a download would need a different mechanism.
  static Future<String?> write(String name, String content) async {
    if (kIsWeb) return null;

    final dir = await getApplicationDocumentsDirectory();
    final stamp = DateTime.now().toIso8601String().split('T').first;
    final file = File('${dir.path}/$name-$stamp.csv');
    await file.writeAsString(content);
    return file.path;
  }
}
