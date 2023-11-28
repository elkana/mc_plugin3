import 'dart:async';

import 'package:get/get.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';
import 'package:mc_plugin3/provider/response/response_mst_classification.dart';
import 'package:mc_plugin3/provider/response/response_mst_nextaction.dart';
import 'package:mc_plugin3/provider/response/response_mst_reason.dart';
import 'package:mc_plugin3/provider/response/response_mst_personal.dart';

import '../controller/auth_controller.dart';
import '../controller/pref_controller.dart';
import '../model/masters.dart';
import '../model/server_model.dart';
import '../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../model/user.dart';
import '../util/commons.dart';
import '../util/device_util.dart';
import '../util/gps_util.dart';
import 'mediaapi.dart';
import 'response/response_assignment.dart';

class Api extends MediaApi {
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
    await 1.delay();
    var d = await post('/matel/auth/v1/signup_nik?devicesn=EMULATOR30X1X2X2',
        server: server,
        data: <String, dynamic>{
          'nik': nik,
        },
        q: await _gpsAsParam);

    return d;
  }

  Future<String?> changePwd(Server server, String? userId, String oldPassword, String newPassword) async {
    await [1, 2].random.delay();
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
    // 1. get outbound header
    var _ = await get('/mc-api/v1-ldv-headers-outbound/search/by-lastDate',
        q: {'collId': AuthController.instance.loggedUserId});
    var header = OTrnLdvHeader.fromMap(_);

    // 2. get outbound details
    _ = await get('/mc-api/v1-ldv-details-outbound/search/by-ldvNo', q: {'ldvNo': header.ldvNo});
    _ = ResponseAssignment.fromMap(_);
    await OTrnLdvDetail().saveOrUpdateAll(_.embedded?.data);
    // 3. need to flush primary keys in separate table
    _.embedded?.data?.forEach((element) => LdvDetailPk().saveOrUpdate(element.pk!));
    // 4. lastly, flush header
    await OTrnLdvHeader().saveOrUpdate(header);
  }

  Future get masters => Future.wait([
        get('/mc-api/v1-mst-personals'),
        get('/mc-api/v1-mst-delq-reasons'),
        get('/mc-api/v1-mst-ldv-classifications'),
        get('/mc-api/v1-mst-next-actions'),
      ]).then((value) {
        MstLdvPersonal().saveOrUpdateAll(ResponseMstPersonal.fromMap(value[0]).embedded?.data);
        MstLdvDelqReason().saveOrUpdateAll(ResponseMstLdvReason.fromMap(value[1]).embedded?.data);
        MstLdvClassification().saveOrUpdateAll(ResponseMstClassification.fromMap(value[2]).embedded?.data);
        MstLdvNextAction().saveOrUpdateAll(ResponseMstNextAction.fromMap(value[3]).embedded?.data);
      });
}
