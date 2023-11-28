import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/server_model.dart';
import '../provider/api.dart';
import '../provider/response/response_apk.dart';
import '../util/commons.dart';
import '../util/customs.dart';
import '../util/device_util.dart';
import 'abasic_controller.dart';
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

  // Server? getSelectedServer() => selectedServer.value.isEmpty() ? null : selectedServer.value;
  // void setServer(Server? newValue) {
  //   if (servers.isNotEmpty && null != newValue) {
  //     selectedServer(servers.firstWhere((e) => e.name == newValue.name));
  //   }
  // }
  // Server? getSelectedServer() => clientLogic?.selectedServer;
  void setServer(Server? newValue) => selectedServer.value = newValue;
  // List<Server> get servers => clientLogic?.servers ?? [];

  // void setServers(List<Server> list) => servers = list;
  // bool isSingleServer() => servers.length == 1;

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
    // await 1.delay();
    if (!await validateAllPermissions()) {
      progressMsg('Permissions Failed.');
      showError('Maaf, Anda harus menyetujui akses ke perangkat.');
      return false;
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
}
