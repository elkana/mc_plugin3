import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import '../exception/exception.dart';
import '../model/server_model.dart';
import '../model/user.dart';
import '../provider/api.dart';
import '../routes/app_routes.dart';
import '../util/commons.dart';
import 'pref_controller.dart';

class AuthController extends GetxService {
  static AuthController instance = Get.find();
  var user = Rxn<UserModel>();

  UserModel? get loggedUser => user.value;
  String get loggedUserId => loggedUser!.userId!;

  @override
  void onInit() {
    super.onInit();
    ever<UserModel?>(user, (_) {
      log('ever-> $_');
      if (_ == null) {
        Get.offAllNamed(Routes.login);
        PrefController.instance.sessionStateStream.add(SessionState.stopListening);
      } else {
        // start listening only after user logs in
        Get.offAllNamed(Routes.home);
        PrefController.instance.sessionStateStream.add(SessionState.startListening);
      }
    });
  }

  Future<UserModel?> login(Server server, String userId, String pwd, bool rememberMe) async {
    UserModel? userModel;

    if (userId == 'offline@yahoo.com' && kDebugMode) {
      userModel = UserModel(
        userId: userId,
        userPassword: pwd,
        fullName: 'Tester Offline',
        emailAddr: userId,
      );
      await 1.delay();
    } else {
      try {
        userModel = await Api.instance.login(server, userId, pwd);
      } on PasswordChangeException {
        var ret = await Get.toNamed(Routes.changePwd, arguments: [server, userId, pwd]);
        if (ret == true) {
          // showToast('Ganti Password SUKSES. Silakan login ulang.');
        }
        return null;
      } catch (e) {
        rethrow;
      }
    }

    log('setting $server for $userModel');
    // userModel?.rememberMe = rememberMe;  removed
    await PrefController.instance.setLastSelectedServer(server);

    // if need to change pwd, skip login, go to change pwd instead
    // if (userModel?.needChangePwd == true) {
    //   // await PrefController.instance.setLoggedUser(userModel);
    //   var ret = await Get.toNamed(Routes.changePwd, arguments: [server, pwd]);
    //   if (ret == true) {
    //     // showToast('Ganti Password SUKSES. Silakan login ulang.');
    //   }
    //   return null;
    // }
    // keep password for local use. will be removed
    userModel?.userPassword = pwd;
    // save rememberme
    await PrefController.instance.setRememberMe(rememberMe);
    if (rememberMe) {
      await PrefController.instance.setRememberUserId(userId);
      await PrefController.instance.setRememberPwd(pwd);
    }

    // await PrefController.instance.setLoggedUser(userModel); pentest failed
    // if (kReleaseMode) await 1.delay();
    // user.value = userModel;  // ! dont put here, sometimes, child need blocks another validation after login
    return userModel;
  }

  logout() async {
    try {
      // TODO harus dipindah ke box utk simpan remember me
      // if (await PrefController.instance.hasLoggedUser()) {
      //   var user = await PrefController.instance.getLoggedUser();
      //   if (user!.rememberMe != true) {
      //     await PrefController.instance.cleanLoggedUserData();
      //   }
      // }
      if (!PrefController.instance.hasRememberMe || PrefController.instance.rememberMe != true) {
        await PrefController.instance.cleanLoggedUserData();
      }
      user.value = null;
    } catch (e, s) {
      showError(e, stacktrace: s);
    }
  }
}
