import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';
import 'package:mc_plugin3/provider/entityapi.dart';
import 'package:mc_plugin3/provider/response/response_mst_classification.dart';
import 'package:mc_plugin3/provider/response/response_mst_nextaction.dart';
import 'package:mc_plugin3/provider/response/response_mst_personal.dart';
import 'package:mc_plugin3/provider/response/response_mst_reason.dart';
import 'package:mc_plugin3/util/hive_util.dart';

import '../controller/auth_controller.dart';
import '../controller/pref_controller.dart';
import '../model/masters.dart';
import '../model/server_model.dart';
import '../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../model/user.dart';
import '../util/commons.dart';
import '../util/device_util.dart';
import '../util/gps_util.dart';
import 'response/response_assignment.dart';

class Api extends EntityApi {
  static Api instance = Get.find();
  var uriLogin = '/mc-api/auth/v1/login';

  Future<Map<String, dynamic>> get _gpsAsParam async {
    var gps = await GpsUtil.currentLocationInForeground;
    return {'lat': '${gps.latitude}', 'lng': '${gps.longitude}'};
  }

  Future<UserModel?> login(Server server, String userId, String userPwd) async {
    var _ = await post('$uriLogin?devicesn=EMULATOR02022023',
        server: server,
        data: <String, dynamic>{'username': userId, 'password': userPwd, 'sysInfo': await DeviceUtil.getSysInfo('|')},
        q: await _gpsAsParam);
    try {
      var user = UserModel.fromMap(_);
      await PrefController.instance.setAccessToken(user.accessToken);
      await PrefController.instance.setRefreshToken(user.refreshToken);
      return user;
    } catch (e, s) {
      log('$e', stacktrace: s);
      return null;
    }
  }

  Future<String?> signUpUsingNIK(Server server, String nik) async {
    if (kReleaseMode) await 1.delay();
    var d = await post('/matel/auth/v1/signup_nik?devicesn=EMULATOR30X1X2X2',
        server: server,
        data: <String, dynamic>{
          'nik': nik,
        },
        q: await _gpsAsParam);

    return d;
  }

  Future<String?> changePwd(Server server, String? userId, String oldPassword, String newPassword) async {
    if (kReleaseMode) await [1, 2].random.delay();
    var loggedUser = AuthController.instance.loggedUser;
    var d = await post('/matel/auth/v1/change_pwd?devicesn=EMULATOR30X1X2X2',
        server: server,
        data: <String, dynamic>{
          'username': userId ?? loggedUser?.userId,
          'oldPwd': oldPassword,
          'newPwd': newPassword,
        },
        q: await _gpsAsParam);
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

  Future get assignments async {
    var _ = await get('/mc-api/ldv/v1-assignment', q: {
      'collId': AuthController.instance.loggedUserId,
      'ldvDate': null,
    });
    var r = ResponseAssignment.fromMap(_);
    await Future.wait([
      // 1. flush transactions
      TrnRVCollComment().saveAll(r.rvColls),
      ITrnLdvDetail().saveAll(r.idetails),
      ITrnLdvHeader().saveOne(r.iheader),
      // 2. flush outbounds
      OTrnLdvDetail()
          .saveAll(r.odetails)
          // need to flush primary keys in separate table
          .then((value) => LdvDetailPk().saveAll(value.map((e) => e.pk!).toList())),
      OTrnLdvHeader().saveOne(r.oheader!),
    ]);
  }

  Future<void> getMasters(bool useCache) async {
    if (!HiveUtil.isMasterEmpty()) return;
    return Future.wait([
      get('/mc-api/v1-mst-personals'),
      get('/mc-api/v1-mst-delq-reasons'),
      get('/mc-api/v1-mst-ldv-classifications'),
      get('/mc-api/v1-mst-next-actions'),
    ]).then((value) {
      MstLdvPersonal().saveAll(ResponseMstPersonal.fromMap(value[0]).embedded?.data);
      MstLdvDelqReason().saveAll(ResponseMstLdvReason.fromMap(value[1]).embedded?.data);
      MstLdvClassification().saveAll(ResponseMstClassification.fromMap(value[2]).embedded?.data);
      MstLdvNextAction().saveAll(ResponseMstNextAction.fromMap(value[3]).embedded?.data);
    });
  }
}
