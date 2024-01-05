import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
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
  await dotenv.load(fileName: '.env');
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  BaseApi.apiKey = '${dotenv.env['APIKEY']}';
  await HiveUtil.registerAdaptersFirstTime();
  await initializeService();
  // must on the top of GetX chains
  await Get.put(PrefController()).initStorage();
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
  Future<String?> getPlatformVersion() => McPlugin3Platform.instance.getPlatformVersion();
}

Future<void> initializeService() async {
  if (kIsWeb) return;
  final service = FlutterBackgroundService();

  // const channel = AndroidNotificationChannel(
  //   notificationChannelId, // id
  //   'MY FOREGROUND SERVICE', // title
  //   description: 'This channel is used for important notifications.', // description
  //   importance: Importance.low, // importance must be at low or higher level
  // );

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: true,

        // notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        // foregroundServiceNotificationId: notificationId,
      ),
      iosConfiguration: IosConfiguration());
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

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        // flutterLocalNotificationsPlugin.show(
        //   888,
        //   'COOL SERVICE',
        //   'Awesome ${DateTime.now()}',
        //   const NotificationDetails(
        //     android: AndroidNotificationDetails(
        //       'my_foreground',
        //       'MY FOREGROUND SERVICE',
        //       icon: 'ic_bg_service_small',
        //       ongoing: true,
        //     ),
        //   ),
        // );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: 'My App Service',
          content: 'Updated at ${DateTime.now()}',
        );
      }
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin
    // final deviceInfo = DeviceInfoPlugin();
    // String? device;
    // if (Platform.isAndroid) {
    //   final androidInfo = await deviceInfo.androidInfo;
    //   device = androidInfo.model;
    // }

    // if (Platform.isIOS) {
    //   final iosInfo = await deviceInfo.iosInfo;
    //   device = iosInfo.model;
    // }

    // service.invoke(
    //   'update',
    //   {
    //     "current_date": DateTime.now().toIso8601String(),
    //     "device": device,
    //   },
    // );
  });
}
