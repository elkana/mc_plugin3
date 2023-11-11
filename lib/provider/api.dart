import 'dart:async';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/pref_controller.dart';
import '../model/server_model.dart';
import '../model/user.dart';
import '../util/commons.dart';
import '../util/gps_util.dart';
import 'mediaapi.dart';
import 'response/response_apk.dart';

class Api extends MediaApi {
  static Api instance = Get.find();
  var uriLogin = '/matel/auth/v2/login'; // 1.0.5
  // var uriLogin = '/matel/auth/v1/login'; // 1.0.0

  Future<UserModel?> login(Server server, String userId, String userPwd) async {
    // await [1].random.delay();
    var gps = await GpsUtil.getCurrentLocationInForeground();
    var sysInfo = '';
    //await DeviceUtil.getSysInfo('|');
    var d = await post('$uriLogin?devicesn=EMULATOR02022023', server: server, data: <String, dynamic>{
      'username': userId,
      'password': userPwd,
      'sysInfo': sysInfo
    }, q: {
      'lat': '${gps.latitude}',
      'lng': '${gps.longitude}',
    });
    try {
      var obj = UserModel.fromMap(d);
      await PrefController.instance.setAccessToken(obj.accessToken);
      await PrefController.instance.setRefreshToken(obj.refreshToken);
      return obj;
    } catch (e, s) {
      log('$e', stacktrace: s);
      return null;
    }
  }

  Future<String?> signUpUsingNIK(Server server, String nik) async {
    await 1.delay();
    var gps = await GpsUtil.getCurrentLocationInForeground();
    var d = await post('/matel/auth/v1/signup_nik?devicesn=EMULATOR30X1X2X2', server: server, data: <String, dynamic>{
      'nik': nik,
    }, q: {
      'lat': '${gps.latitude}',
      'lng': '${gps.longitude}',
    });

    return d;
  }

  Future<String?> changePwd(Server server, String? userId, String oldPassword, String newPassword) async {
    await [1, 2].random.delay();
    var gps = await GpsUtil.getCurrentLocationInForeground();
    var loggedUser = AuthController.instance.loggedUser;
    var d = await post('/matel/auth/v1/change_pwd?devicesn=EMULATOR30X1X2X2', server: server, data: <String, dynamic>{
      'username': userId ?? loggedUser?.userId,
      'oldPwd': oldPassword,
      'newPwd': newPassword,
    }, q: {
      'lat': '${gps.latitude}',
      'lng': '${gps.longitude}',
    });
    return d;
  }

  /// cara kedua via setup, tp masalahnya setup hanya bisa diakses apabila berhasil login krn banyak data credential disana
  // Future<ResponseApk?> checkVersionApk() async {
  //   var d = await get('/matel/setup/v1/check_apk', q: {
  //     'client_build_number': await DeviceUtil.buildNumber, //1
  //     'client_abi': await DeviceUtil.abiInfo, //armeabi-v71
  //     'client_sn': await DeviceUtil.snDevice //RR8H...
  //   });
  //   return ResponseApk.fromMap(d);
  // }
}
