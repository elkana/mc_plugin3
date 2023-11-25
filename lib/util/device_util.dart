import 'dart:io';

import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:safe_device/safe_device.dart';

import '../widget/common.dart';
import 'commons.dart';

class DeviceUtil {
  static Future<bool> isConnected() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        return true;
      }

      // 13 jan 21 ternyata lookup ke google bisa lama. never happenned before.
      // sementara disable dulu fitur ini
      // final result = await InternetAddress.lookup('google.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   return true;
      // }
    } on Exception catch (_) {}
    return false;
  }

  static Future<bool> isNotConnected() async => !(await isConnected());

  /// di native android, ada local.properties::flutter.versionCode
  /// flutter.versionCode itu sama dengan packageInfo.buildNumber
  ///
  /// @return buildNumber / versionCode
  static Future<int> get buildNumber async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) return 3; // tlg disesuaikan dengan pubspec.yaml
    final packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;

    // print(
    //     'Device package info for $appName :: $packageName :: $version :: $buildNumber');

    return int.parse(buildNumber);
  }

  /// Be careful , this is slow (70 ms - 200 ms). You need to store in cache first time
  static Future<String> get abiInfo async {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) return '$defaultTargetPlatform';
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    // var processors = SysInfo.processors;

    // return processors.
    // return SysInfo.kernelArchitecture;
    // return "unknown";
    return androidInfo.supportedAbis[0];
  }

  // static Future<String> get snDevice async {
  //   if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) return 'serialnumber';
  //   // return await responseFromNative('sn');
  //   return await MatelPlugin.snDevice;
  // }

  static Future<String> getVersionInformation({bool includeBuildNumber = true}) async {
    final packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    return includeBuildNumber ? '$version+$buildNumber' : version;
  }

// restricted to device only, incompatbile with web
  static Future<bool> allPermissionsGranted() async {
    if (kIsWeb || Platform.isWindows) return true;

    // if (await ph.Permission.locationAlways.request().isGranted ||
    //     await ph.Permission.locationWhenInUse.request().isGranted) {
    // } else {
    //   await ph.openAppSettings();
    //   return false;
    // }
    if (await ph.Permission.location.request().isGranted) {
    } else {
      await ph.openAppSettings();
      return false;
    }

    // if (!await ph.Permission.phone.request().isGranted) {
    //   await ph.openAppSettings();
    //   return false;
    // }
    // if (!await ph.Permission.storage.request().isGranted) {
    //   await ph.openAppSettings();
    //   return false;
    // }

// TODO problem android 8 and 10. need to check later
    // if (!await ph.Permission.manageExternalStorage.request().isGranted) {
    //   // await ph.openAppSettings();
    //   // return false;
    // }

    return true;
  }

  static Future<bool> checkLocationPermission() async {
    if (await ph.Permission.locationAlways.serviceStatus.isEnabled) {
      // Use location.
      return true;
    } else {
      await ph.openAppSettings();
      return false;
    }
  }

  /// Be careful , this is slow (200 ms - 300 ms). You need to store in cache first time
  static Future<String> getSysInfo(String separator) async {
    final packageInfo = await PackageInfo.fromPlatform();
    var list = [
      (packageInfo.appName),
      (!kReleaseMode ? "packageName : ${packageInfo.packageName}" : ''),
      'version : ${packageInfo.version}',
      'buildNumber : ${packageInfo.buildNumber}',
    ];

    if (GetPlatform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release; //5.1.1
      var sdkInt = androidInfo.version.sdkInt; //22
      var manufacturer = androidInfo.manufacturer; //samsung
      var model = androidInfo.model; //SM-A310F
      var hardware = androidInfo.hardware; //samsungexynos7580
      var isPhysicalDevice = androidInfo.isPhysicalDevice; //true boolean

      String supportedAbis = '';
      for (var s in androidInfo.supportedAbis) {
        supportedAbis += '$s\n';
      }

      list.addAll([
        'android version : $release',
        'android API : $sdkInt',
        'Manufacturer : $manufacturer',
        'Model : $model',
        'Hardware : $hardware',
        'isPhysicalDevice : $isPhysicalDevice',
        'supportedAbis : $supportedAbis',
        // 'deviceRoot : ${(await MatelPlugin.deviceIsRooted == 'false') ? 'No' : 'Yes'}',
        // 'deviceSN : ${await snDevice}',
        // 'deviceID : ${await MatelPlugin.uniqueID}'
      ]);
    }

    if (GetPlatform.isWeb) {
      var webInfo = await DeviceInfoPlugin().webBrowserInfo;
      list.addAll(['userAgent : ${webInfo.userAgent}']);
    }

    return list.join(separator);
  }

  static Future<bool> checkNonEligibleDevice() async {
    // 13 oct 2022
    // if (kIsWeb) return true;
    // var deviceIsRoot = await MatelPlugin.deviceIsRooted;
    // log('Cek ROOT -> $deviceIsRoot');

    // 10jul23 msh lolos ternyata. may deprecated afer prod
    // var nastyApps = await scanNastyPackages();
    // if (nastyApps.isNotEmpty) {
    //   await Get.bottomSheet(
    //       [
    //         'Kamu Tidak bisa Menggunakan Aplikasi ini'.text.bold.make().marginOnly(top: 8, bottom: 12),
    //         'Aplikasi tidak dapat beroperasi dengan aplikasi berikut:\n${nastyApps.join('\n')}'.text.sm.make(),
    //         MyButton('Tutup Aplikasi', onTap: () => exit(0)).marginOnly(top: 40)
    //       ].column().p12().card.make(),
    //       enableDrag: false);
    //   return kDebugMode || false;
    // }

    bool rootAccess = false;
    // if (GetPlatform.isAndroid) {
    //   // 10jul23 msh lolos ternyata
    //   // rootAccess = await RootAccess.requestRootAccess;
    // }

    // if (/*deviceIsRoot != 'false' || */ rootAccess) {
    //   await DataUtil.cleanAll(true);
    //   await Get.bottomSheet(
    //       [
    //         'Kamu Tidak bisa Menggunakan Aplikasi ini'.text.bold.make().marginOnly(top: 8, bottom: 12),
    //         'Aplikasi tidak dapat beroperasi di piranti Rooted'.text.sm.make(),
    //         MyButton('Tutup Aplikasi', onTap: () => exit(0)).marginOnly(top: 40)
    //       ].column().p12().card.make(),
    //       enableDrag: false);
    //   return kDebugMode || false;
    // }

    // untested cause safedevice might use rootbeer
    if (GetPlatform.isAndroid) {
      rootAccess = await SafeDevice.isJailBroken;
      if (kReleaseMode && rootAccess == false) {
        rootAccess = !await SafeDevice.isRealDevice;
      }
    }
    if (rootAccess) {
      // await Get.bottomSheet(
      //     [
      //       'Kamu Tidak bisa Menggunakan Aplikasi ini'.text.bold.make().marginOnly(top: 8, bottom: 12),
      //       'Aplikasi tidak dapat beroperasi di piranti Rooted'.text.sm.make(),
      //       MyButton('Tutup Aplikasi', onTap: () => exit(0)).marginOnly(top: 40)
      //     ].column().p12().card.make(),
      //     enableDrag: false);
      return kDebugMode || false;
    }

    // if (GetPlatform.isAndroid) {
    //   rootAccess = await Root.isRooted() ?? false;
    // }

    if (rootAccess) {
      // await Get.bottomSheet(
      //     [
      //       'Kamu Tidak dapat Menggunakan Aplikasi ini'.text.bold.make().marginOnly(top: 8, bottom: 12),
      //       'Aplikasi tidak dapat beroperasi di perangkat Rooted'.text.sm.make(),
      //       MyButton('Tutup Aplikasi', onTap: () => exit(0)).marginOnly(top: 40)
      //     ].column().p12().card.make(),
      //     enableDrag: false);
      return kDebugMode || false;
    }

    // if (GetPlatform.isAndroid) {
    //   var str = await MatelPlugin.deviceIsRooted;
    //   rootAccess = str != 'false';
    // }

    if (rootAccess) {
      // await Get.bottomSheet(
      //     [
      //       'Kamu dilarang menggunakan Aplikasi ini'.text.bold.make().marginOnly(top: 8, bottom: 12),
      //       'Aplikasi tidak dapat beroperasi di perangkat Rooted'.text.sm.make(),
      //       MyButton('Tutup Aplikasi', onTap: () => exit(0)).marginOnly(top: 40)
      //     ].column().p12().card.make(),
      //     enableDrag: false);
      return kDebugMode || false;
    }

    if (kIsWeb || defaultTargetPlatform == TargetPlatform.windows) {
    } else {
      // disabled krn pak Agung ga setuju
      // bool jailbroken = await FlutterJailbreakDetection.jailbroken;
      // bool developerMode = await FlutterJailbreakDetection.developerMode; // android only.
      // pentest need bypass developmentmode
      // if (await SafeDevice.isDevelopmentModeEnable) {
      //   await Get.bottomSheet(
      //       [
      //         'Kamu Tidak bisa Menggunakan Aplikasi ini'.text.bold.make().marginOnly(top: 8, bottom: 12),
      //         'Mode "Developer Options" di perangkat anda aktif. Untuk melanjutkan, silakan nonaktifkan "Developer Options" pada Pengaturan.'
      //             .text
      //             .sm
      //             .make(),
      //         MyButton('Tutup Aplikasi', onTap: () => exit(0)).marginOnly(top: 40)
      //       ].column().p12().card.make(),
      //       //     shape: const RoundedRectangleBorder(
      //       //         borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      //       enableDrag: false);
      //   return false;
      // }
    }
    return true;
  }

  // https://stackoverflow.com/questions/1101380/determine-if-running-on-a-rooted-device
  // static Future<List<String>> scanNastyPackages() async {
  //   var appName = <String>[];
  //   final forbidPackages = [
  //     'com.thirdparty.superuser',
  //     'eu.chainfire.supersu',
  //     'com.noshufou.android.su',
  //     'com.koushikdutta.superuser',
  //     'com.zachspong.temprootremovejb',
  //     'com.ramdroid.appquarantine',
  //     'com.topjohnwu.magisk',
  //     // diluar rekomendasi i3
  //     'com.yellowes.su',
  //     'com.noshufou.android.su.elite',
  //     'com.koushikdutta.rommanager',
  //     'com.koushikdutta.rommanager.license',
  //     'com.dimonvideo.luckypatcher',
  //     'com.chelpus.lackypatch',
  //     'com.ramdroid.appquarantinepro',
  //     'com.android.vending.billing.InAppBillingService.COIN',
  //     'com.chelpus.luckypatcher',
  //     // rootcloakingapps
  //     'com.devadvance.rootcloak',
  //     'com.devadvance.rootcloakplus',
  //     'de.robv.android.xposed.installer',
  //     'com.saurik.substrate',
  //     'com.amphoras.hidemyroot',
  //     'com.amphoras.hidemyrootadfree',
  //     'com.formyhm.hiderootPremium',
  //     'com.formyhm.hideroot'
  //   ];
  //   List<Application> apps = await DeviceApps.getInstalledApplications();
  //   if (apps.where((e) {
  //     var found = forbidPackages.contains(e.packageName);
  //     if (found) appName.add(e.appName);
  //     return found;
  //   }).isNotEmpty) {
  //     log('Forbidden apps found -> ${appName.join(',')}');
  //   }
  //   return appName;
  // }
}
