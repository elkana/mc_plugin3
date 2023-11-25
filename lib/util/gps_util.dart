import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'net_util.dart';

class LatLng {
  final double latitude;
  final double longitude;
  const LatLng(
    this.latitude,
    this.longitude,
  );
  Object toJson() => <double>[latitude, longitude];
}

class GpsUtil {
  // istana negara
  static const gpsIstanaNegara = LatLng(-6.168195193572678, 106.82404392800761);
  static const gpsMallTA = LatLng(-6.179103584845802, 106.79204741138035);
  static const gpsMallCiputra = LatLng(-6.168621863673647, 106.78611168544974);

// aman dipanggil. kalau gagal akan return 0.0, 0.0
  static Future<LatLng> get currentLocationInForeground async {
    const timeoutInSeconds = 5; // udah kutes kalau 3 detik malah suka ga dapat lokasi !
    try {
      var pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: await NetUtil.isNotConnected
              ? LocationAccuracy.bestForNavigation // mulai 1.2.4 spy bisa di offline
              : LocationAccuracy.high,
          timeLimit: const Duration(seconds: timeoutInSeconds)); // 6 too long
      // await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return LatLng(pos.latitude, pos.longitude);
    } catch (e) {
      debugPrint(
          'GAGAL mendapat lokasi dlm wkt $timeoutInSeconds detik. Switch to last known location. => ${e.toString()}');
      try {
        var lastPos = await Geolocator.getLastKnownPosition();
        return LatLng(lastPos!.latitude, lastPos.longitude);
      } catch (e) {
        debugPrint('LatLng(0,0) => Reason: getCurrentLocationInForeground error => ${e.toString()}');
        return const LatLng(0, 0);
      }
    } finally {}
  }

  static Future callGoogleMaps(String address, [var latitude, var longitude]) async {
    bool usingLatLng = latitude != null && longitude != null;
    String query;
    query = usingLatLng ? '$latitude,$longitude' : Uri.encodeComponent(address);
    launchUrlString('https://www.google.com/maps/search/?api=1&query=$query');
  }
}
