import 'dart:async';
import 'dart:io';
import 'package:media_scanner/media_scanner.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:statusaver/functionnss/all_functions.dart';



class ImageDetail extends StatefulWidget {
  final String? imagePath;

  const ImageDetail({Key? key, this.imagePath}) : super(key: key);

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  // This will print "image1354544212.jpg"


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildBackground(),
            Positioned(
                left: 15,
                bottom: 10,
                child: buildShare()),
            Positioned(
                right: 15,
                bottom: 10,
                child: buildDownload()),
            // Positioned(
            //   right: 15,
            //   bottom: 10,
            //   child: buildDownload(),
            // ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: buildTitle(),

            ),


          ],
        ),
      ),

    );
  }

  Widget buildTitle() => Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.only(left: 5,top: 10),
      child: Row(

        children: [
          Expanded(
              flex: 1,
              child: Container(
                //   color: Colors.black,
                height: 40,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    height: 40,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          child: Icon(


                              Icons.arrow_back_rounded, size: 30)),
                    ),
                  ),
                ),

                // color: Colors.red,
              )),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              child: Center(child: Text(path.basename(widget.imagePath.toString()), style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),)),

            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                height: 40,
                //  color: Colors.black,
              ))
        ],
      ),
    ),
  );



  Widget buildDownload() => IconButton(
    icon: Icon(
      Icons.download_rounded,
      color: Colors.white,
      size: 40,
    ),

    onPressed:() async{



      //   this code is saving images in internal storage and doesn't not showing the images in gallery
      String foldername="Statussaversimages";
      String sourceDirectoryPath = widget.imagePath!;
      final downloadFolderPath = '/storage/emulated/0/Download/$foldername';
      await AllFunctions.copyFileToDownloadFolder(
          sourceDirectoryPath, downloadFolderPath, context);




    },
  );

  Widget buildShare() => IconButton(
    icon: Icon(
      Icons.share,
      color: Colors.white,
      size: 40,
    ),
    onPressed: () {

      final file = File(widget.imagePath!); // Replace with the actual file path

      Share.shareFiles([file.path], text: 'Check out this image!');


    },
  );



  Widget buildBackground() => PhotoView(
    imageProvider: FileImage(File(widget.imagePath!)),
    backgroundDecoration: BoxDecoration(
      color: Colors.black,
    ),
  );


}





