import 'package:get/get.dart';
import 'package:mc_plugin3/controller/pref_controller.dart';

import '../../controller/alogin_controller.dart';
import '../../controller/auth_controller.dart';
import '../../provider/api.dart';
import '../../provider/baseapi.dart';
import '../../routes/app_routes.dart';
import '../../util/commons.dart';
import '../../util/web_util.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LoginController>(() => LoginController());
}

class LoginController extends ALoginController {
  static LoginController instance = Get.find();
  var expanded = false.obs;
  var isLogoAnimReady = false.obs;

  Future allowSSLWeb() async =>
      WebUtil.openNewTab(await BaseApi.getSelectedServer(selectedServer.value), isNewTab: true);
  void gotoRegister() => Get.toNamed(Routes.signup, arguments: [selectedServer.value]);

  @override
  void onReady() {
    super.onReady();
    expanded.value = true;
  }

  Future<void> doLogin() async => loading.isTrue
      ? null
      : await processThis(() async {
          // 1. check validation
          if (!await validatePreLogin()) return;
          progressMsg('Logging in...');
          // 2. online authentication
          var user = await AuthController.instance
              .login(selectedServer.value!, ctrlUserId.text, ctrlPwd.text, rememberPwd.value)
              .onError((e, s) {
            showError(e.toString(), title: 'Login Failed');
            return null;
          });
          if (user == null) {
            //bypass login, jika masih ada data ldv di lokal
            final userLocal = await PrefController.instance.rememberUser;
            if (userLocal != null &&
                userLocal.userId == ctrlUserId.text &&
                userLocal.userPassword == ctrlPwd.text &&
                rememberPwd.isTrue) {
            } else {
              // punishment for wrong password
              await [2, 5].random.delay();
              return;
            }
            user = userLocal;
          } // 3. download setups
          // progressMsg('Setups...');
          // await PrefController.instance.downloadSetup();
          progressMsg('Masters...');
          await Api.instance.masters;
          // 4. finally, validation is PASSED
          AuthController.instance.user(user);
        });
}
