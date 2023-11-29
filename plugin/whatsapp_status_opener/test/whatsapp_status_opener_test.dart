import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_status_opener/whatsapp_status_opener.dart';
import 'package:whatsapp_status_opener/whatsapp_status_opener_platform_interface.dart';
import 'package:whatsapp_status_opener/whatsapp_status_opener_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWhatsappStatusOpenerPlatform
    with MockPlatformInterfaceMixin
    implements WhatsappStatusOpenerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WhatsappStatusOpenerPlatform initialPlatform = WhatsappStatusOpenerPlatform.instance;

  test('$MethodChannelWhatsappStatusOpener is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWhatsappStatusOpener>());
  });

  test('getPlatformVersion', () async {
    WhatsappStatusOpener whatsappStatusOpenerPlugin = WhatsappStatusOpener();
    MockWhatsappStatusOpenerPlatform fakePlatform = MockWhatsappStatusOpenerPlatform();
    WhatsappStatusOpenerPlatform.instance = fakePlatform;

    expect(await whatsappStatusOpenerPlugin.getPlatformVersion(), '42');
  });
}
