import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../exception/exception.dart';
import '../util/commons.dart';
import '../util/device_util.dart';
import 'auth_controller.dart';

/// dont use this on login / other than authenticated screen
abstract class ABasicController extends GetxController {
  var loading = false.obs;
  // counter disediakan utk memungkinkan bisa input meskipun aplikasi error. jgn lupa di reset jika sukses.
  var errorCounter = 0;
  final maxError = 5;

  Future<void> logout() => AuthController.instance.logout();

  Future loadingThis(Future<void> Function() call, Function(Object e, StackTrace s)? onError) async {
    // if (loading.isTrue) return; // bahaya jika kelupaan awalnya udah true saat onInit
    loading(true);
    try {
      await call();
    } catch (e, s) {
      if (onError != null) onError(e, s);
    } finally {
      loading(false);
    }
  }

  Future processThis(Future<void> Function() call, [bool dialog = false]) => loadingThis(call, (e, s) {
        String title = '';
        if (e is CodeException) title = '${e.code}';
        dialog ? confirmOk('$e'.normalizeException(), title: title) : showError(e, stacktrace: s, title: title);
      });

  Future cleanDatabase(BuildContext context) async {
    // await DataUtil.cleanAll(true);
    context.showToast(msg: 'Data Cleanup SUCCESS');
  }

  Future<bool> validateAllPermissions() async {
    if (!await DeviceUtil.allPermissionsGranted()) return false;
    // if (!await checkLocationService()) return false;
    return true;
  }
}
