import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mc_plugin3_platform_interface.dart';

/// An implementation of [McPlugin3Platform] that uses method channels.
class MethodChannelMcPlugin3 extends McPlugin3Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mc_plugin3');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
