import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_plugin3/mc_plugin3_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMcPlugin3 platform = MethodChannelMcPlugin3();
  const MethodChannel channel = MethodChannel('mc_plugin3');

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
