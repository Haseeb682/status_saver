

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:whatsapp_status_opener/whatsapp_status_opener.dart';

import '../Constants/constant.dart';

class GetStatusProvider extends ChangeNotifier {

  List<String> _getImages=[];
  List<String> _getVideos=[];
  bool _isWhatsAppAvailable = false;

  List<String> get getImages => _getImages;
  List<String> get getVideos => _getVideos;
  bool get isWhatsAppAvailable => _isWhatsAppAvailable;



  Future<bool> getStatus() async {
    // Your 'res' value to store in shared preferences
    String res = "content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fmedia%2Fcom.whatsapp%2FWhatsApp%2FMedia%2F.Statuses";

    // Store 'res' in shared preferences with the key 'treeUri'
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String treeuri=await WhatsappStatusOpener.openStatusesFolder(customPath: res)??"";

    if(treeuri.isNotEmpty && treeuri ==AppConstants.pr_waUri){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      await prefs.setString("Urivalue", treeuri);
      AppConstants.whtsptreeuri=treeuri;
      print("calling get real status");

      print('this is whatsapp treeuri ${treeuri}');
      getwhatsappstatus(treeuri);
      return true;

    }else{
      Center(child: Text("Please give permission"),);
    }

    return false;

  }

  Future<bool> getbussinessstatus() async {
    // Your 'res' value to store in shared preferences
    String res = "content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fmedia%2Fcom.whatsapp.w4b%2FWhatsApp Business%2FMedia%2F.Statuses";

    // Store 'res' in shared preferences with the key 'treeUri'
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String bussinesstreeuri=await WhatsappStatusOpener.openStatusesFolder(customPath: res)??"";

    if(bussinesstreeuri.isNotEmpty && bussinesstreeuri==AppConstants.pr_bsnsWaUri){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      await prefs.setString("bussinessUrivalue", bussinesstreeuri);
      AppConstants.bsneswhtspuri=bussinesstreeuri;
      print("calling bussiness get status");

      print('this is bussiness whatsapp treeuri ${bussinesstreeuri}');
      getwhatsappbussinessstatus(bussinesstreeuri);
      return true;

    }else{
      Center(child: Text("Please give permission"),);

    }
    return false;


  }


  Future <void> getwhatsappstatus(String treeuri) async {
    _getImages.clear();
    _getVideos.clear();

    String input=await WhatsappStatusOpener.getStatusesFolder(treeUri: treeuri);
    print(input);
    String cleanedInput =
    input.replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '');

    // Split the cleaned input by ','
    var urilist = cleanedInput.split(',');

    // Remove leading and trailing whitespace from each URL
    urilist = urilist.map((url) => url.trim()).toList();

    for (int i = 1; i < urilist.length; i++) {
      var path = await toFilePath(urilist[i]);
      if(path.endsWith(".jpg")){
        _getImages.add(path);
      }else{
        _getVideos.add(path);
      }
      _isWhatsAppAvailable=true;
      notifyListeners();


    }
    getwhatsappbussinessstatus(AppConstants.bsneswhtspuri!);

  }


  Future <void> getwhatsappbussinessstatus(String treeuri) async {
    String input=await WhatsappStatusOpener.getStatusesFolder(treeUri: treeuri);
    print(input);
    String cleanedInput =
    input.replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '');

    // Split the cleaned input by ','
    var urilist = cleanedInput.split(',');

    // Remove leading and trailing whitespace from each URL
    urilist = urilist.map((url) => url.trim()).toList();

    for (int i = 1; i < urilist.length; i++) {
      var path = await toFilePath(urilist[i]);
      if(path.endsWith(".jpg")){
        _getImages.add(path);
      }else{
        _getVideos.add(path);
      }
      _isWhatsAppAvailable=true;
      notifyListeners();


    }

  }



}
