import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStatusProviderdownloads extends ChangeNotifier {

  List<String> _getdownloadImages=[];
  List<String> _getdownloadVideos=[];


  List<String> get getdImages => _getdownloadImages;
  List<String> get getdVideos => _getdownloadVideos;

  Future<void> getdownloadStatus() async {
    // Retrieve stored paths from SharedPreferences
    List<String>? storedPaths = await getStoredPaths();

    if (storedPaths != null && storedPaths.isNotEmpty) {
      // Clear existing lists before adding new files
      _getdownloadImages.clear();
      _getdownloadVideos.clear();

      // Iterate over the stored paths and add them to the corresponding lists.
      for (final storedPath in storedPaths) {
        if (storedPath.endsWith('.jpg')) {
          _getdownloadImages.add(storedPath);
        } else if (storedPath.endsWith('.mp4')) {
          _getdownloadVideos.add(storedPath);
        }
      }

      // Notify the listeners that the download folder data has changed.
      notifyListeners();

    }
  }
  Future<List<String>?> getStoredPaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('downloaded_files');
  }
}
