import 'dart:async';
import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'mc_plugin3_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/pref_controller.dart';
import 'model/mc_trn_coll_pos.dart';
import 'provider/baseapi.dart';
import 'util/commons.dart';
import 'util/customs.dart';
import 'util/device_util.dart';
import 'util/hive_util.dart';

Future<void> registerBeforeRunApp(CustomTheme? theme, CustomLogic logic) async {
  await dotenv.load(fileName: '.env');
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  BaseApi.apiKey = '${dotenv.env['APIKEY']}';

  await HiveUtil.registerAdaptersFirstTime();
  await initializeService();
  // must on the top of GetX chains
  await Get.put(PrefController()).initStorage();
  if (!kIsWeb && !io.Platform.isWindows) {
    // var sn = await DeviceUtil.snDevice;
    // if (sn.toLowerCase() == 'unknown') sn = '';
    // sayangnya baru cuma bisa baca android
    var s = await DeviceUtil.getVersionInformation(includeBuildNumber: false);
    await PrefController.instance.setAppVersion('v.$s');
  }
  clientTheme = theme;
  clientLogic = logic;
}

class McPlugin3 {
  Future<String?> getPlatformVersion() => McPlugin3Platform.instance.getPlatformVersion();
}

Future<void> initializeService() async {
  if (kIsWeb) return;
  await FlutterBackgroundService().configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        // auto start service
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
      ));
}

@pragma('')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    try {
      await TrnCollPos.writeToCache();
    } catch (err) {
      print(err);
    }
  });
}
