// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:io';

import 'package:flutter/services.dart';

import 'whatsapp_status_opener_platform_interface.dart';






class WhatsappStatusOpener {
  static const MethodChannel _channel =
      const MethodChannel('whatsapp_status_opener');

  Future<String?> getPlatformVersion() {
    return WhatsappStatusOpenerPlatform.instance.getPlatformVersion();
  }    

  static Future<String?> openStatusesFolder({String? customPath}) async {
    if (Platform.isAndroid) {
    
        try {
         return await _channel.invokeMethod('openStatusesFolder', {'customPath': customPath});
        } on PlatformException catch (e) {
          
          print("Error opening folder: $e");
          return "error plgn";
        }
      
    } else {
      
      print("This feature is only supported on Android");
      return "error plgn";
    }
  }

  static Future<String> getStatusesFolder( {String? treeUri}) async {
    if (Platform.isAndroid) {
    
        try {
         return await _channel.invokeMethod('getWhatsAppStatusFolder', {'treeUri': treeUri});
        } on PlatformException catch (e) {
          
          print("Error opening folder: $e");
          return "error plgn";
        }
      
    } else {
      
      print("This feature is only supported on Android");
      return "error plgn";
    }
  }
}

