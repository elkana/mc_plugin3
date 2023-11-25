import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

// for web, use web_util
class NetUtil {
  static Future<bool> get isNotConnected async => !(await isConnected);

  static Future<bool> get isConnected async {
    if (kIsWeb) return true;
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;

      // 13 jan 21 ternyata lookup ke google bisa lama. never happenned before.
      // sementara disable dulu fitur ini
      // final result = await InternetAddress.lookup('google.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   return true;
      // }
    } on SocketException catch (_) {}
    return false;
  }
}
