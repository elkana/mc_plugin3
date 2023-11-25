import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/pref_controller.dart';
import '../../generated/locales.g.dart';
import '../../model/server_model.dart';
import '../../util/customs.dart';
import '../../util/validate_util.dart';
import '../../widget/common.dart';
import 'login_controller.dart';

// Just a raw version of login page. Vendor should customized itself.
class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(context) => Scaffold(
      body: Obx(() => [
            Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.formKey,
                    child: [
                      // email
                      MyTextFormField('ID',
                          hintText: 'UserID (tanpa spasi)',
                          controller: controller.ctrlUserId,
                          validator: ValidateUtil.userId,
                          onSaved: (val) => controller.ctrlUserId.text = val!).marginOnly(bottom: 16, top: 20),
                      //password
                      MyTextFormField(LocaleKeys.hints_password.tr,
                          controller: controller.ctrlPwd,
                          validator: ValidateUtil.password,
                          onSaved: (val) => controller.ctrlPwd.text = val!,
                          obscureText: controller.obscurePwd.value,
                          suffixIcon: IconButton(
                              icon: Icon(controller.obscurePwd.isTrue
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () => controller.obscurePwd.toggle())),
                      // toggle rememberme
                      TextButton.icon(
                          label: LocaleKeys.buttons_rememberme.tr.text.make(),
                          onPressed: controller.rememberPwd.toggle,
                          icon: Switch(
                              value: controller.rememberPwd.value,
                              onChanged: (val) => controller.rememberPwd.toggle())),
                      '${controller.progressMsg}'.text.make(),
                      //button login
                      OutlinedButton(
                          onPressed: controller.doLogin,
                          child: controller.loading.isTrue
                              ? const CircularProgressIndicator()
                              : LocaleKeys.buttons_login.tr.toUpperCase().text.make()),
                      InputDecorator(
                              decoration: const InputDecoration(labelText: 'Server :', border: InputBorder.none),
                              isEmpty: controller.selectedServer.value == null,
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Server>(
                                      value: controller.selectedServer.value,
                                      isDense: true,
                                      onChanged: controller.setServer,
                                      items: clientLogic!.servers
                                          .map((value) =>
                                              DropdownMenuItem<Server>(value: value, child: value.name!.text.make()))
                                          .toList())))
                          .hide(isVisible: kDebugMode || clientLogic!.servers.length > 1),
                      PrefController.instance.appVersion.text.make(),
                    ].column())
                .box
                .padding(const EdgeInsets.fromLTRB(24, 24, 24, 8))
                .makeCentered(),
            'Sign Up Here'.text.make().onTap(controller.gotoRegister),
          ].column().scrollVertical().expand()).safeArea());
}
