import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/server_model.dart';
import '../model/user.dart';
import '../provider/api.dart';
import '../provider/baseapi.dart';
import '../routes/app_routes.dart';
import '../util/commons.dart';
import '../util/customs.dart';
import '../util/device_util.dart';
import '../util/hive_util.dart';
import '../util/web_util.dart';
import 'abasic_controller.dart';
import 'auth_controller.dart';
import 'pref_controller.dart';

abstract class ALoginController extends ABasicController {
  final formKey = GlobalKey<FormState>();
  // change to 0 to check version and download latest apk
  int attemptUpdateApk = 1;
  // late List<Server> servers;
  // var selectedServer = Server().obs;
  var selectedServer = Rxn<Server>();

  var retryCounter = 0;
  var maxRetry = 3;
  // will be multiplied by 2 to add more delay when user keep agitating
  var retrySeconds = 60;
  var runningCounter = 0.obs;
  Timer? _timerFailedLogin;

  final ctrlUserId = TextEditingController();
  final ctrlPwd = TextEditingController();
  var obscurePwd = true.obs;
  var rememberPwd = false.obs;

  Future onPostLogin();

  void setServer(Server? newValue) => selectedServer.value = newValue;
  Future allowSSLWeb() async => WebUtil.openNewTab(selectedServer.value!.toAddress(), isNewTab: true);
  void gotoRegister() => Get.toNamed(Routes.signup, arguments: [selectedServer.value]);

  @override
  void onInit() {
    super.onInit();
    // setup preferences
    rememberPwd(PrefController.instance.rememberMe ?? false);
    if (rememberPwd.isTrue) {
      PrefController.instance.rememberUser.then((value) {
        ctrlUserId.text = value?.userId ?? '';
        ctrlPwd.text = value?.userPassword ?? '';
      });
    }
    // pick a server
    PrefController.instance.lastSelectedServer.then((value) => setServer(value ?? clientLogic!.servers[0]));
  }

  @override
  void onReady() {
    super.onReady();
    // show message when logout due to expired token
    PrefController.instance.popLastMessage();
  }

  Future<void> actionLogin() async => loading.isTrue
      ? null
      : await processThis(() async {
          // 1. check validation
          if (!await validatePreLogin()) return;
          progressMsg('Logging in...');
          // 2. online authentication
          var user = await AuthController.instance
                  .login(selectedServer.value!, ctrlUserId.text, ctrlPwd.text, rememberPwd.value)
                  .onError((e, s) {
                if (e.toString().contains('410')) {
                  throw Exception('Maaf Akun Anda terblokir');
                }
                showError(e.toString(), title: 'Login Failed');
                return null;
              }) ??
              await attemptOfflineUser;

          if (user == null) {
            // punishment for wrong password
            if (kReleaseMode) await [2, 5].random.delay();
            return;
          }
          await onPostLogin();
          progressMsg('Masters...');
          await Api.instance.getMasters(true);

          // 4. finally, validation is PASSED
          AuthController.instance.user(user);
        });

  Future<bool> validatePreLogin() async {
    // 1. avoid login if downloading apk still in progress
    if (progressMsg.trim().toLowerCase().startsWith('download')) {
      showToast('Sedang Proses Update.. mohon ditunggu');
      return false;
    }
    // 1. validate form
    if (!formKey.currentState!.validate()) return false;
    // 2. check Root for android only
    if (!await DeviceUtil.checkNonEligibleDevice()) return false;
    // 3. check permission
    progressMsg('Checking Permissions...');
    if (!await validateAllPermissions()) {
      progressMsg('Permissions Failed.');
      showError('Maaf, Anda harus menyetujui akses ke perangkat.');
      return false;
    }
    // check user change
    var lastUser = await PrefController.instance.rememberUser;
    if (lastUser?.userId == ctrlUserId.text) {
    } else if (lastUser != null && lastUser.userId != ctrlUserId.text) {
      if (await confirm('Ada perubahan login akun.\nLanjut login sebagai ${ctrlUserId.text}')) {
        await HiveUtil.cleanAll(true);
      } else {
        return false;
      }
    }
    formKey.currentState!.save();
    // selectedServerByUser = selectedServer.value;
    // 5. check version
    // await checkVersion(); //disable since 10 jul 23, may cause new problem
    return true;
  }

  void test(String userId, String pwd) {
    ctrlPwd.text = pwd;
    ctrlUserId.text = userId;
  }

  Future<UserModel?> get attemptOfflineUser async {
    final userLocal = await PrefController.instance.rememberUser;
    if (userLocal != null &&
        userLocal.userId == ctrlUserId.text &&
        userLocal.userPassword == ctrlPwd.text &&
        rememberPwd.isTrue) {
      return userLocal;
    }
    return null;
  }
}
