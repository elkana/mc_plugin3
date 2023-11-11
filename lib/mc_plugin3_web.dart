// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'mc_plugin3_platform_interface.dart';

/// A web implementation of the McPlugin3Platform of the McPlugin3 plugin.
class McPlugin3Web extends McPlugin3Platform {
  /// Constructs a McPlugin3Web
  McPlugin3Web();

  static void registerWith(Registrar registrar) {
    McPlugin3Platform.instance = McPlugin3Web();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }
}
