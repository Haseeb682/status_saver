import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFunctions {
  static List<String> downloadedFileNames = [];

  static Future<void> copyFileToDownloadFolder(
      String sourceFilePath, String destinationFolderPath, BuildContext context) async {
    final sourceFile = File(sourceFilePath);
    final destinationDirectory = Directory(destinationFolderPath);
    if (!await sourceFile.exists()) {
      print('Source file does not exist.');
      return;
    }

    if (!await destinationDirectory.exists()) {
      await destinationDirectory.create(recursive: true);
    }

    final fileName = path.basename(sourceFilePath);
    final destinationFile = File(path.join(destinationFolderPath, fileName));

    try {
      // Copy the file
      await sourceFile.copy(destinationFile.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image $fileName copied to $destinationFolderPath.'),
          duration: Duration(seconds: 2),
        ),
      );

      // Save file path to the static list
      downloadedFileNames.add(sourceFilePath);

      // Save file path to SharedPreferences
      await saveFileNameToSharedPreferences(fileName);
      print("calling shared prefrence stored data");
      //printStoredPaths();
    }
    catch (e) {
      print('Error copying file $fileName: $e');
    }
  }

  static Future<void> copyFilevideoToDownloadFolder(
      String sourceFilePath, String destinationFolderPath, BuildContext context) async {
    final sourceFile = File(sourceFilePath);
    final destinationDirectory = Directory(destinationFolderPath);

    if (!await sourceFile.exists()) {
      print('Source file does not exist.');
      return;
    }

    if (!await destinationDirectory.exists()) {
      await destinationDirectory.create(recursive: true);
    }

    final fileName = path.basename(sourceFilePath);
    final destinationFile = File(path.join(destinationFolderPath, fileName));

    try {
      // Copy the file
      await sourceFile.copy(destinationFile.path);

      // Save file path to the static list
      downloadedFileNames.add(sourceFilePath);

      // Save file path to SharedPreferences
      await saveFileNameToSharedPreferences(fileName);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video $fileName copied to $destinationFolderPath.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error copying file $fileName: $e');
    }
  }

  static Future<void> saveFileNameToSharedPreferences(String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('downloaded_files', downloadedFileNames);
  }

  static Future<void> loadPaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    downloadedFileNames = prefs.getStringList('downloaded_files')??[];

  }
}
