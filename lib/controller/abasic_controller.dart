import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../exception/exception.dart';
import '../routes/app_routes.dart';
import '../util/commons.dart';
import '../util/device_util.dart';
import '../util/hive_util.dart';
import 'auth_controller.dart';

/// dont use this on login / other than authenticated screen
abstract class ABasicController extends GetxController {
  var loading = false.obs;
  var progressMsg = ''.obs;
  // counter disediakan utk memungkinkan bisa input meskipun aplikasi error. jgn lupa di reset jika sukses.
  var errorCounter = 0;
  final maxError = 5;

  Future<bool> logout() => AuthController.instance.logout();
  void viewDatabase() => Get.toNamed(Routes.developer);

  Future loadingThis(Future<void> Function() call, Function(Object e, StackTrace s)? onError) async {
    loading(true);
    update();
    try {
      await call();
    } catch (e, s) {
      if (onError != null) onError(e, s);
    } finally {
      loading(false);
      progressMsg('');
      update();
    }
  }

  Future processThis(Future<void> Function() call, [bool dialog = false]) => loadingThis(call, (e, s) {
        String title = '';
        if (e is CodeException) title = '${e.code}';
        dialog ? confirmOk('$e'.normalizeException(), title: title) : showError(e, stacktrace: s, title: title);
      });

  Future cleanDatabase(BuildContext context) async {
    await HiveUtil.cleanAll(true);
    context.showToast(msg: 'Data Cleanup SUCCESS');
  }

  Future<bool> validateAllPermissions() async {
    if (!await DeviceUtil.allPermissionsGranted()) return false;
    // if (!await checkLocationService()) return false;
    return true;
  }
}

abstract class AViewController extends ABasicController {
  Future refreshData();

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }
}

abstract class AHomeController extends AViewController {
  var pageIndex = 0;

  void changePageIndex(int index) {
    pageIndex = index;
    update();
  }

  @override
  Future refreshData() async {
    //
  }
}

// differ from ATabFormController
abstract class ATabController extends AViewController {
  late TabController tabController;

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
