import 'package:get/get.dart';

import '../../controller/alogin_controller.dart';
import '../../controller/auth_controller.dart';
import '../../provider/baseapi.dart';
import '../../routes/app_routes.dart';
import '../../util/commons.dart';
import '../../util/web_util.dart';

class LoginController extends ALoginController {
  static LoginController instance = Get.find();
  var expanded = false.obs;
  var isLogoReady = false.obs;

  void allowSSLWeb() => WebUtil.openNewTab(BaseApi.constructHostPort(selectedServer.value), isNewTab: true);
  void gotoRegister() => Get.toNamed(Routes.signup, arguments: [selectedServer.value]);

  @override
  void onReady() {
    super.onReady();
    expanded.value = true;
  }

  Future<void> doLogin() async {
    if (loading.isTrue) return;
    return loadingThis(() async {
      // 1. check validation
      if (!await validatePreLogin()) return;
      progressMsg('Logging in...');
      // 2. online authentication
      final user = await AuthController.instance
          .login(selectedServer.value!, ctrlUserId.text, ctrlPwd.text, rememberPwd.value)
          .onError((error, stackTrace) {
        showError(error.toString(), title: 'Login Failed');
        return null;
      });
      if (user == null) {
        // punishment for wrong password
        await [2, 5].random.delay();
        progressMsg('');
        return;
      }
      // 3. download setups
      progressMsg('Setups...');
      // await PrefController.instance.downloadSetup();
      // 4. finally, validation is PASSED
      AuthController.instance.user(user);
    }, (e, s) {
      progressMsg('');
      showError(e, stacktrace: s);
    });
  }

  void test(String userId, String pwd) {
    ctrlPwd.text = pwd;
    ctrlUserId.text = userId;
  }
}
