import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'whatsapp_status_opener_platform_interface.dart';

/// An implementation of [WhatsappStatusOpenerPlatform] that uses method channels.
class MethodChannelWhatsappStatusOpener extends WhatsappStatusOpenerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('whatsapp_status_opener');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
