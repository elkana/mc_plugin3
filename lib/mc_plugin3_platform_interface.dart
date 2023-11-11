import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mc_plugin3_method_channel.dart';

abstract class McPlugin3Platform extends PlatformInterface {
  /// Constructs a McPlugin3Platform.
  McPlugin3Platform() : super(token: _token);

  static final Object _token = Object();

  static McPlugin3Platform _instance = MethodChannelMcPlugin3();

  /// The default instance of [McPlugin3Platform] to use.
  ///
  /// Defaults to [MethodChannelMcPlugin3].
  static McPlugin3Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [McPlugin3Platform] when
  /// they register themselves.
  static set instance(McPlugin3Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
