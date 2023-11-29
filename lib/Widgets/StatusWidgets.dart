import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:statusaver/Constants/constant.dart';
import 'package:statusaver/Provider/getStatusProvider.dart';
import '../Screens/HomeScreen/imagedetailscreen.dart';
import '../Screens/HomeScreen/videodetailscreen.dart';
import '../Utils/getThumbnails.dart';
import '../functionnss/all_functions.dart';

class Statuswidgets extends StatefulWidget {
  bool isshow;

  Statuswidgets({required this.isshow, Key? key}) : super(key: key);

  static GlobalKey<_StatuswidgetsState> statusWidgetsKey =
  GlobalKey<_StatuswidgetsState>();

  @override
  State<Statuswidgets> createState() => _StatuswidgetsState();
}

class _StatuswidgetsState extends State<Statuswidgets> {
  bool _isFetched = false; // Flag to keep track of whether status is fetched
  bool _iswhtspPermissionDialogOpen = false;
  bool _isbsnswhtsppermissiondialogopen=false;

  @override
  void initState() {
    super.initState();
    _iswhtspPermissionDialogOpen=false;
    _isbsnswhtsppermissiondialogopen=false;
   // chekPermission();
    _checkPlatformVersion();

  }

  chekPermission() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppConstants.whtsptreeuri = await prefs.getString("Urivalue") ?? '';
    AppConstants.bsneswhtspuri = await prefs.getString("bussinessUrivalue") ?? '';
    print('permi ${AppConstants.whtsptreeuri}');
    print('bsnswhtsp permission uri ${AppConstants.bsneswhtspuri}');

    if (AppConstants.whtsptreeuri!.isNotEmpty) {
      // Set _isFetched to true when the user explicitly requests to fetch status
      _isFetched = true;
      // NavBar(isWhatsAppSelected: true, isBusinessWhatsAppSelected: false);
      setState(() {

      });
      Provider.of<GetStatusProvider>(context, listen: false).getwhatsappstatus(AppConstants.whtsptreeuri!);
    }
    else if (AppConstants.bsneswhtspuri!.isNotEmpty) {
      // Set _isFetched to true when the user explicitly requests to fetch status
      _isFetched = true;
      setState(() {

      });
      Provider.of<GetStatusProvider>(context, listen: false).getwhatsappbussinessstatus(AppConstants.bsneswhtspuri!);
    } else {

    }

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,bottom: MediaQuery.of(context).size.width*0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isFetched)
                  InkWell(
                    onTap: (){
                      _showwhtspPermissionDialog();
                    },
                    child: Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width * 0.58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        border: Border.all(color: Colors.green, width: 2.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/whtsp.png', height: 24, width:MediaQuery.of(context).size.width * 0.08), // Adjust height and width as needed
                              ],
                            ),
                            SizedBox(width: 20),

                             // Add spacing between icon and text
                            Expanded(

                              child: Text(
                                "WhatsApp",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 5,),
                if(!_isFetched)
                  InkWell(

                    onTap: (){
                      _showbsnswhtspPermissionDialog();
                    },
                    child: Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width * 0.58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        border: Border.all(color: Colors.green, width: 2.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/bsnswhtsp.png', height: 24, width:MediaQuery.of(context).size.width * 0.08,), // Adjust height and width as needed
                            SizedBox(width: 8), // Add spacing between icon and text
                            Text(
                              "Business WhatsApp",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                if (_isFetched)
                  Expanded(
                    child: Consumer<GetStatusProvider>(
                      builder: (context, file, child) {
                        return file.isWhatsAppAvailable == false
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : file.getImages.isEmpty
                            ? Center(
                          child: Text("No image"),
                        )
                            : Container(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 3 / 2,
                              shrinkWrap: true,
                              children: List.generate(
                                widget.isshow
                                    ? file.getImages.length
                                    : file.getVideos.length,
                                    (index) {
                                  final data = file.getImages[index];
                                  final videoData = file.getVideos != null &&
                                      index < file.getVideos.length
                                      ? file.getVideos[index]
                                      : null;
                                  print(data);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: widget.isshow
                                        ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageDetail(
                                              imagePath: data,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(),
                                            child: IconButton(
                                              icon: Icon(Icons.file_download_outlined),
                                              onPressed: () async {
                                                String foldername = "Statussaversimages";
                                                String sourceDirectoryPath = data;
                                                final downloadFolderPath = '/storage/emulated/0/Download/$foldername';
                                                await AllFunctions.copyFileToDownloadFolder(sourceDirectoryPath, downloadFolderPath, context);
                                              },
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                              File(data),
                                            ),
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        ),
                                      ),
                                    )
                                        : FutureBuilder<String>(
                                      future: getThumbnail(videoData!),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => VideoPlayerScreen(
                                                    videoPath: videoData,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(),
                                                  child: IconButton(
                                                    icon: Icon(Icons.file_download_outlined),
                                                    onPressed: () async {
                                                      String foldername = "Statussaversimages";
                                                      String sourceDirectoryPath = videoData;
                                                      final downloadFolderPath = '/storage/emulated/0/Download/$foldername';
                                                      await AllFunctions.copyFilevideoToDownloadFolder(sourceDirectoryPath, downloadFolderPath, context);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(
                                                    File(snapshot.data!),
                                                  ),
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            )
                                        ): Center(child: CircularProgressIndicator());
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit App?'),
          content: Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showwhtspPermissionDialog() {
    if (_iswhtspPermissionDialogOpen) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Square corners
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Allows the dialog to shrink to fit content
              children: [
                Container(
                  height: 100, // Half of the dialog height
                  color: Colors.green, // Green upper half
                  child: Center(
                    child: Icon(
                      Icons.folder,
                      size: 35, // Icon size
                      color: Colors.white, // Icon color
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                    padding: EdgeInsets.only(left: 15.0,right:15.0),
                    child: Text("To save status, allow Status Saverr access to your device storage")),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text("Allow",style: TextStyle(color: Colors.green),),
                        onPressed: () async{
                          // Close the dialog
                          Navigator.of(context).pop();
                          // Set the flag to indicate that the permission dialog is open

                          // Call the getstatus function from the provider
                       bool result=await   Provider.of<GetStatusProvider>(context, listen: false).getStatus();
                          // Set the flag to indicate that status is fetched
                          setState(() {
                            _isFetched = result;
                            _iswhtspPermissionDialogOpen = result;
                          });
                        },
                      ),
                      TextButton(
                        child: Text("Deny",style: TextStyle(color: Colors.green),),
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          // Set the flag to indicate that the permission dialog is open
                          _iswhtspPermissionDialogOpen = false;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  void _showbsnswhtspPermissionDialog() {
    if (_isbsnswhtsppermissiondialogopen) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Square corners
          ),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Allows the dialog to shrink to fit content
              children: [
                Container(
                  height: 100, // Half of the dialog height
                  color: Colors.green, // Green upper half
                  child: Center(
                    child: Icon(
                      Icons.folder,
                      size: 35, // Icon size
                      color: Colors.white, // Icon color
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                    padding: EdgeInsets.only(left: 15.0,right:15.0),
                    child: Text("To save status, allow Status Saverr access to your device storage")),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text("Allow",style: TextStyle(color: Colors.green),),
                        onPressed: () async{
                          // Close the dialog
                          Navigator.of(context).pop();
                          // Set the flag to indicate that the permission dialog is open

                          // Call the getstatus function from the provider
                          bool result=await Provider.of<GetStatusProvider>(context, listen: false).getbussinessstatus();
                          // Set the flag to indicate that status is fetched
                          setState(() {
                            _isFetched = result;
                            _isbsnswhtsppermissiondialogopen = result;
                          });
                        },
                      ),
                      TextButton(
                        child: Text("Deny",style: TextStyle(color: Colors.green),),
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                          // Set the flag to indicate that the permission dialog is open
                          _iswhtspPermissionDialogOpen = false;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Set the flag to indicate that the permission dialog is open
    //  _isPermissionDialogOpen = true;
  }

  Future<void> _checkPlatformVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo;

    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;

      // Check Android version
      if (androidInfo.version.sdkInt >= 11) {
        // Version is 11 or above, call checkPermission
        Fluttertoast.showToast(
          msg: "Your Android version is above 11. you are ready to go",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        chekPermission();
      } else {
        // Version is below 11, show a toast message
        Fluttertoast.showToast(
          msg: "Your Android version is below 11. Status Saverr requires Android 11 or above.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else if (Platform.isIOS) {
      // Check iOS version
      if (int.parse(Platform.operatingSystemVersion.split('.')[0]) >= 11) {
        // Version is 11 or above, call checkPermission
        chekPermission();
      } else {
        // Version is below 11, show a toast message
        Fluttertoast.showToast(
          msg: "Your iOS version is below 11. Status Saverr requires iOS 11 or above.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

}

