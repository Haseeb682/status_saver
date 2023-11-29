import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import '../Provider/getstatusproviderdownload.dart';
import '../Screens/HomeScreen/imagedetailscreen.dart';
import '../Screens/HomeScreen/videodetailscreen.dart';
import '../Utils/getThumbnails.dart';


class Downloadwidgets extends StatefulWidget {
  bool isshows;
  Downloadwidgets({required this.isshows, Key? key}) : super(key: key);

  @override
  State<Downloadwidgets> createState() => _DownloadwidgetsState();
}

class _DownloadwidgetsState extends State<Downloadwidgets> {

  bool _isfetched = false;
  List images=[''];
  List vedios=[''];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      // Show the exit confirmation dialog
      _showExitConfirmationDialog(context);
      return false;
    },
      child: Scaffold(
          body: Consumer<GetStatusProviderdownloads>(builder: (context,file,child){
            if(_isfetched == false){
              file.getdownloadStatus();
              Future.delayed(Duration(microseconds: 1), (){
                _isfetched=true;
              });
            }

            return file.getdImages.isEmpty ? Center(
              child: Text("No image"),)
                :Container(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(

                      )),
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 3/2,
                        shrinkWrap: true,
                        children: List.generate(widget.isshows?file.getdImages.length:file.getdVideos.length, (index) {
                          final data=file.getdImages[index];
                          final videoData = file.getdVideos != null && index < file.getdVideos.length ? file.getdVideos[index] : null;
                          return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              child:widget.isshows? GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(
                                      builder: (context) =>  ImageDetail(
                                        imagePath:data,
                                      )));
                                },
                                child:Container(

                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(data)
                                        )
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0),),
                                  ),
                                ),
                              ):  // yahan tk images k liay data tha is sy aagy videos ka container shuru hoo geya h
                              file.getdVideos.isEmpty ? Center(
                                child: Text("No Video"),
                              ):FutureBuilder<String>(
                                future: getThumbnail(videoData!),
                                builder: (context,snapshot){
                                  return snapshot.hasData ? GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(
                                          builder: (context) =>  VideoPlayerScreen(
                                            videoPath: videoData,
                                          )));
                                    },
                                    child:Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(snapshot.data!)
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      //  child: Center(child: Text(file.getVideos[index].path)),
                                    ),
                                  ):Center(child: CircularProgressIndicator());

                                  //Center(child: Text("No videos"),);

                                },

                              )
                          );
                        },),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(

                      ))
                ],
              ),
            );
          },
          )

      ),);

  }
}

Future<void> _showExitConfirmationDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      // Return an AlertDialog widget
      return AlertDialog(
        title: Text('Exit App?'),
        content: Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              // Close the dialog and return to the screen
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Exit'),
            onPressed: () { // Close the dialog and exit the app
              Navigator.of(context).pop();
              SystemNavigator.pop(); // Exit the app
            },
          ),
        ],
      );
    },
  );
}