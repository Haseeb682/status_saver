

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statusaver/Provider/getStatusProvider.dart';
import 'package:statusaver/Provider/getstatusproviderdownload.dart';
import 'package:statusaver/Screens/SplashScreen/splash_screen.dart';

import 'functionnss/all_functions.dart';

void main() {
  runApp(const MyApp());
  AllFunctions.loadPaths();
}

void Loadpaths() {
  // Iterate through the downloadedFileNames list and store each path
  for (var path in AllFunctions.downloadedFileNames) {
    // Perform any logic you need with the path
    print('Storing path: $path');

    // If you want to store it in a variable, you can do so here
    // For example, assuming you have a list variable in your main.dart
    // List<String> storedPaths = [];
    // storedPaths.add(path);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
        ChangeNotifierProvider(create: (_) => GetStatusProviderdownloads())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
      ),
    );
  }
}

