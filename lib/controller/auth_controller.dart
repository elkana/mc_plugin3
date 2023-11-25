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

    log('setting $server for $userModel');
    await PrefController.instance.setLastSelectedServer(server);

    userModel?.userPassword = pwd;
    // save rememberme
    await PrefController.instance.setRememberMe(rememberMe);
    if (rememberMe) {
      // await PrefController.instance.setRememberUserId(userId);
      // await PrefController.instance.setRememberPwd(pwd);
      await PrefController.instance.setRememberUser(userModel);
    }

    // await PrefController.instance.setLoggedUser(userModel); pentest failed
    // if (kReleaseMode) await 1.delay();
    // user.value = userModel;  // ! dont put here, sometimes, child need blocks another validation after login
    return userModel;
  }

  logout() async {
    try {
      if (!PrefController.instance.hasRememberMe || PrefController.instance.rememberMe != true) {
        await PrefController.instance.cleanLoggedUserData();
      }
      user.value = null;
    } catch (e, s) {
      showError(e, stacktrace: s);
    }
  }
}
