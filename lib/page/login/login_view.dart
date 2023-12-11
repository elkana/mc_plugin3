import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
class LoginView extends GetView<LoginBasicController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(context) => Scaffold(
      body: Obx(() => [
            Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.formKey,
                    child: [
                      // email
                      InputUserId(controller.ctrlUserId).marginOnly(bottom: 16, top: 20),
                      //password
                      InputUserPwd(controller.ctrlPwd,
                          obscurePwd: controller.obscurePwd.value, onToggle: controller.obscurePwd),
                      // toggle rememberme
                      ToggleRememberMe(controller.rememberPwd.value, onToggle: controller.rememberPwd),
                      '${controller.progressMsg}'.text.make(),
                      //button login
                      OutlinedButton(
                          onPressed: controller.actionLogin,
                          child: controller.loading.isTrue
                              ? const CircularProgressIndicator()
                              : LocaleKeys.buttons_login.tr.text.make()),
                      DropDownServers(selServer: controller.selectedServer.value, onChanged: controller.setServer),
                      PrefController.instance.appVersion.text.make(),
                    ].column())
                .box
                .padding(const EdgeInsets.fromLTRB(24, 24, 24, 8))
                .makeCentered(),
            'Sign Up Here'.text.make().onTap(controller.gotoRegister),
          ].column().scrollVertical().expand()).safeArea());
}

// reusable
class InputUserId extends StatelessWidget {
  final TextEditingController tfController;
  const InputUserId(this.tfController, {super.key});

  @override
  Widget build(context) => MyTextFormField('ID',
      hintText: 'UserID (tanpa spasi)',
      controller: tfController,
      validator: ValidateUtil.userId,
      suffixIcon: const SizedBox(),
      onSaved: (val) => tfController.text = val!);
}

// reusable
class InputUserPwd extends StatelessWidget {
  final TextEditingController tfController;
  final bool obscurePwd;
  final Function(bool) onToggle;
  const InputUserPwd(this.tfController, {super.key, required this.obscurePwd, required this.onToggle});

  @override
  Widget build(context) => MyTextFormField(LocaleKeys.hints_password.tr,
      controller: tfController,
      validator: ValidateUtil.password,
      onSaved: (val) => tfController.text = val!,
      obscureText: obscurePwd,
      suffixIcon: IconButton(
          icon: Icon(obscurePwd ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          onPressed: () => onToggle(!obscurePwd)));
}

// reusable
class ToggleRememberMe extends StatelessWidget {
  final bool value;
  final bool invert;
  final Function(bool) onToggle;
  const ToggleRememberMe(this.value, {super.key, this.invert = false, required this.onToggle});

  @override
  Widget build(context) => TextButton.icon(
        label: invert
            ? Switch(value: value, onChanged: (val) => onToggle(val))
            : LocaleKeys.buttons_rememberme.tr.text.make(),
        onPressed: () => onToggle(!value),
        icon: invert
            ? LocaleKeys.buttons_rememberme.tr.text.make()
            : Switch(value: value, onChanged: (val) => onToggle(val)),
      );
}

// reusable
class DropDownServers extends StatelessWidget {
  final Server? selServer;
  final Function(Server?)? onChanged;
  const DropDownServers({super.key, this.selServer, required this.onChanged});

  @override
  Widget build(context) => InputDecorator(
          decoration: const InputDecoration(
              labelText: 'Server :', labelStyle: TextStyle(fontSize: 12), border: InputBorder.none),
          isEmpty: selServer == null,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<Server>(
                  value: selServer,
                  isDense: true,
                  onChanged: onChanged,
                  items: clientLogic!.servers
                      .map((value) => DropdownMenuItem<Server>(value: value, child: value.name!.text.sm.make()))
                      .toList())))
      .hide(isVisible: kDebugMode || clientLogic!.servers.length > 1);
}
