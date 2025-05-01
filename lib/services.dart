import 'dart:io';
import 'dart:typed_data';
  import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
 
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

  static Future<void> saveFile(Uint8List fileBytes, String fileName) async {
  try {
     await FlutterFileSaver().writeFileAsBytes(
    fileName: fileName,
    bytes: fileBytes,
);

     
  } catch (e) {
    print("Error saving file: $e");
  }
  }
}
