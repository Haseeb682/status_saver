import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;

  VideoPlayerScreen({required this.videoPath});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(

        children: [
          Center(
              child:_controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : CircularProgressIndicator() ),

          Positioned(
            top: 40.0,
            left: 10.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            top: 55.0,
            left: 75.0,
            child: Center(child: Text(path.basename(widget.videoPath.toString()), style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400
            ),)),
          ),


          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: IconButton(
              icon: Icon(
                Icons.download_rounded,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () async {
                // Implement download functionality here

                String foldername="Statussaversimages";
                String sourceDirectoryPath = widget.videoPath!;
                final downloadFolderPath = '/storage/emulated/0/Download/$foldername';
                await copyFileToDownloadFolder(
                    sourceDirectoryPath, downloadFolderPath);


              },
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                final file = File(widget.videoPath!); // Replace with the actual file path

                Share.shareFiles([file.path], text: 'Check out this image!');

                // Implement share functionality here
              },
            ),
          ),
          Center(
            child: IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  Future<void> copyFileToDownloadFolder(
      String sourceFilePath, String destinationFolderPath) async {
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
      MediaScanner.loadMedia(path: widget.videoPath!);

      // print('Video $fileName copied successfully to $destinationFolderPath.');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video $fileName copied to $destinationFolderPath.'),
          duration: Duration(seconds: 2), // Optional: Set the duration

        ),
      );

      // If you want to delete the original file after copying, uncomment the next line:
      // await sourceFile.delete();
    } catch (e) {
      print('Error copying file $fileName: $e');
    }
  }


}
