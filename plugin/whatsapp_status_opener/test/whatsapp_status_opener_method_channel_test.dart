import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whatsapp_status_opener/whatsapp_status_opener_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWhatsappStatusOpener platform = MethodChannelWhatsappStatusOpener();
  const MethodChannel channel = MethodChannel('whatsapp_status_opener');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
