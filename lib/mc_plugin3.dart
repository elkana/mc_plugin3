import 'dart:io';

import 'mc_plugin3_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'controller/pref_controller.dart';
import 'provider/baseapi.dart';
import 'util/customs.dart';
import 'util/device_util.dart';
import 'util/hive_util.dart';

Future<void> registerBeforeRunApp(CustomTheme? theme, CustomLogic logic) async {
  await dotenv.load(fileName: ".env");
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  BaseApi.apiKey = '${dotenv.env['APIKEY']}';
  await HiveUtil.registerAdaptersFirstTime();
  // must on the top of GetX chains
  await Get.put(PrefController()).initStorage();
  // await PrefController.instance.setServers(servers);
  if (!kIsWeb && !Platform.isWindows) {
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
  Future<String?> getPlatformVersion() {
    return McPlugin3Platform.instance.getPlatformVersion();
  }
}
