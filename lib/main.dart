import 'dart:developer';
import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:saving_file_example/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                file = await Services.createCSV();
                log(file?.path.toString() ?? 'file is null');
              },
              child: Text('create file'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await Services.saveFile( await file!.readAsBytes(), 'my_document.csv');
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text('save file'),
            ),
          ],
        ),
      ),
    );
  }
}
