import 'package:flutter_test/flutter_test.dart';
import 'package:mc_plugin3/mc_plugin3.dart';
import 'package:mc_plugin3/mc_plugin3_platform_interface.dart';
import 'package:mc_plugin3/mc_plugin3_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMcPlugin3Platform
    with MockPlatformInterfaceMixin
    implements McPlugin3Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final McPlugin3Platform initialPlatform = McPlugin3Platform.instance;

  test('$MethodChannelMcPlugin3 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMcPlugin3>());
  });

  test('getPlatformVersion', () async {
    McPlugin3 mcPlugin3Plugin = McPlugin3();
    MockMcPlugin3Platform fakePlatform = MockMcPlugin3Platform();
    McPlugin3Platform.instance = fakePlatform;

    expect(await mcPlugin3Plugin.getPlatformVersion(), '42');
  });
}
