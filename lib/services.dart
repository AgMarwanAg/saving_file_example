import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;

class Services {
  // Sample data
  static final List<Map<String, dynamic>> data = [
    {"id": 1, "name": "John Doe", "email": "john@example.com", "age": 30, "isActive": true},
    {"id": 2, "name": "Jane Smith", "email": "jane@example.com", "age": 25, "isActive": false},
    {"id": 3, "name": "Bob Johnson", "email": "bob@example.com", "age": 40, "isActive": true},
  ];

  static Future<File?> createCSV() async {
    try {
      // Extract headers from first item
      final headers = data.first.keys.toList();

      // Convert data rows
      final rows = [headers, ...data.map((row) => headers.map((h) => row[h]).toList())];

      // Convert to CSV
      final csvString = const ListToCsvConverter().convert(rows);

      // Get directory to save file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/exported_data.csv';

      // Write file
      final file = File(filePath);
      await file.writeAsString(csvString);

      return file;
    } catch (e) {
      debugPrint('Failed to export CSV: $e');
      return null;
    }
  }

  static Future<void> saveFileWithPicker({required Uint8List fileBytes, required String fileName}) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        final filePath = p.join(selectedDirectory, fileName);
        final file = File(filePath);
        await file.writeAsBytes(fileBytes);
        print('File saved to: $filePath');
      } else {
        print('User canceled directory selection');
      }
    } catch (e) {
      print('Error saving file: $e');
    }
  }
}
