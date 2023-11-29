import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'whatsapp_status_opener_method_channel.dart';

abstract class WhatsappStatusOpenerPlatform extends PlatformInterface {
  /// Constructs a WhatsappStatusOpenerPlatform.
  WhatsappStatusOpenerPlatform() : super(token: _token);

  static final Object _token = Object();

  static WhatsappStatusOpenerPlatform _instance = MethodChannelWhatsappStatusOpener();

  /// The default instance of [WhatsappStatusOpenerPlatform] to use.
  ///
  /// Defaults to [MethodChannelWhatsappStatusOpener].
  static WhatsappStatusOpenerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WhatsappStatusOpenerPlatform] when
  /// they register themselves.
  static set instance(WhatsappStatusOpenerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
