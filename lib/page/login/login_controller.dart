import 'package:get/get.dart';

import '../../controller/alogin_controller.dart';

class LoginBasicBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LoginBasicController>(() => LoginBasicController());
}

class LoginBasicController extends ALoginController {
  @override
  Future onPostLogin() {
    // TODO: implement onPostLogin
    throw UnimplementedError();
  }
}
