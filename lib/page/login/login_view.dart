import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/pref_controller.dart';
import '../../generated/locales.g.dart';
import '../../model/server_model.dart';
import '../../util/commons.dart';
import '../../util/customs.dart';
import '../../util/validate_util.dart';
import '../../widget/common.dart';
import '../../widget/animations/fade_anim.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LoginController>(() => LoginController());
}

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(context) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
          backgroundColor: Get.isDarkMode ? null : clientTheme?.colorMain,
          appBar: kReleaseMode
              ? null
              : AppBar(
                  actions: [
                    GetBuilder<PrefController>(
                        builder: (_) => Switch(
                            value: Get.isDarkMode,
                            onChanged: (value) async {
                              await DynamicTheme.of(context)!.setTheme(!value ? 0 : 1);
                              await _.setDarkTheme(value);
                              log('Get.isDarkMode ${Get.isDarkMode}');
                              PrefController.instance.update();
                            })),
                    TextButton(onPressed: controller.allowSSLWeb, child: 'AllowSSL'.text.white.make())
                        .hide(isVisible: kIsWeb),
                    TextButton(
                        child: 'Pentest'.text.white.make(),
                        onPressed: () => controller.test('es21110056', 'Welcome1!')),
                    TextButton(
                        child: 'User 1'.text.white.make(),
                        // onPressed: () => controller.test('ES21120013', 'Password123!')),
                        onPressed: () => controller.test('ES21120013', 'Password123\$')),
                    TextButton(
                        child: 'User 2'.text.white.make(), onPressed: () => controller.test('elkana911', 'Elkana9!!')),
                    TextButton(
                        child: 'User 3'.text.white.make(), onPressed: () => controller.test('yola123', '@Yola12345')),
                    TextButton(child: 'Clear DB'.text.white.make(), onPressed: () => controller.cleanDatabase(context))
                  ],
                ),
          body: Obx(() => [
                [
                  LogoAnimation(0.1,
                          onCompleted: () => controller.isLogoReady(true),
                          child: (clientTheme
                                  ?.getLoginLogo(context)
                                  .wh(160, 160)
                                  .pOnly(left: 60, right: 60, top: 60, bottom: 30) ??
                              const SizedBox()))
                      .py20(),
                  20.heightBox,
                  // (clientTheme?.getLoginLogo(context).wh(160, 160) ?? const SizedBox()).animate().fade().slide(),
                  [
                    // 'LOGIN'.text.xl4.white.fontFamily(GoogleFonts.jetBrainsMono().fontFamily!).make(),
                    const Spacer(),
                    TextButton(onPressed: controller.gotoRegister, child: 'Daftar / Lupa Password'.text.white.xs.make())
                  ].row(axisSize: MainAxisSize.max).pSymmetric(h: 40).hide(isVisible: false),
                  AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: Container(
                          child: controller.expanded.isFalse
                              ? null
                              : Form(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      key: controller.formKey,
                                      child: [
                                        // email
                                        MyTextFormField('ID',
                                                hintText: 'UserID (tanpa spasi)',
                                                controller: controller.ctrlUserId,
                                                validator: ValidateUtil.userId,
                                                suffixIcon: const SizedBox(),
                                                onSaved: (val) => controller.ctrlUserId.text = val!)
                                            .marginOnly(bottom: 16, top: 20)
                                            .fadeTopDownAnim(2),
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
                                                onPressed: () => controller.obscurePwd.toggle())).fadeTopDownAnim(2.5),
                                        // toggle rememberme
                                        [
                                          TextButton.icon(
                                              label: LocaleKeys.buttons_rememberme.tr.text.xs.make(),
                                              onPressed: controller.rememberPwd.toggle,
                                              icon: Switch(
                                                  value: controller.rememberPwd.value,
                                                  onChanged: (val) => controller.rememberPwd.toggle())),
                                        ]
                                            .row(axisSize: MainAxisSize.max, alignment: MainAxisAlignment.spaceBetween)
                                            .marginOnly(bottom: 10)
                                            .fadeTopDownAnim(2.7),
                                        '${controller.progressMsg}'.text.xs.indigo700.make().py(10),
                                        //button login
                                        Hero(
                                          tag: 'fabHome',
                                          child: MaterialButton(
                                            onPressed: controller.doLogin,
                                            color: Colors.indigo,
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: Colors.black),
                                                borderRadius: BorderRadius.circular(22.0)),
                                            child: controller.loading.isTrue
                                                ? const CircularProgressIndicator(color: Colors.white).wh(20, 20)
                                                : LocaleKeys.buttons_login.tr
                                                    .toUpperCase()
                                                    .text
                                                    .bold
                                                    .letterSpacing(2)
                                                    .white
                                                    .make(),
                                          ).box.width(136).height(42).make().objectCenter().marginOnly(top: 0),
                                        ).fadeDownTopAnim(2.8),
                                        InputDecorator(
                                                decoration: const InputDecoration(
                                                    labelText: 'Server :',
                                                    labelStyle: TextStyle(fontSize: 11),
                                                    border: InputBorder.none),
                                                isEmpty: controller.selectedServer.value == null,
                                                child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<Server>(
                                                        value: controller.selectedServer.value,
                                                        isDense: true,
                                                        onChanged: controller.setServer,
                                                        items: clientLogic!.servers
                                                            .map((value) => DropdownMenuItem<Server>(
                                                                value: value, child: value.name!.text.sm.make()))
                                                            .toList())))
                                            .hide(isVisible: kDebugMode || clientLogic!.servers.length > 1),
                                        PrefController.instance.appVersion.text.scale(0.5).make().objectCenterRight(),
                                      ].column())
                                  .box
                                  .padding(const EdgeInsets.fromLTRB(24, 24, 24, 8))
                                  .shadowLg
                                  .white
                                  .roundedLg
                                  .makeCentered()
                                  .marginSymmetric(horizontal: 60))),
                  'Daftar / Lupa Kata Kunci'
                      .text
                      .white
                      .xs
                      .bold
                      .make()
                      .onTap(controller.gotoRegister)
                      .opacity75()
                      .objectCenter()
                      .fadeDownTopAnim(2)
                      .py(14),
                ].column().scrollVertical().expand(),
                'MIZUHO LEASING INDONESIA'.text.xs.white.letterSpacing(6).make().marginOnly(bottom: 12),
              ].column()).safeArea()));
}
