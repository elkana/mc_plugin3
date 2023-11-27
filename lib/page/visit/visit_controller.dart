import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_lkp_dtl/o_trn_lkp_dtl.dart';
import 'package:mc_plugin3/util/commons.dart';
import '../../controller/aformbuilder_controller.dart';
import '../../controller/auth_controller.dart';

class VisitBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<VisitController>(() => VisitController());
}

class VisitController extends AFormBuilderController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  LdvDetailPk? contractPk;
  var initialValue = Rxn<TrnRVCollComment>();
  dynamic get formChanges => formKey.currentState?.value ?? {};
  var submitting = false.obs;
  var bertemuDengan = ''.obs;
  @override
  void onInit() {
    super.onInit();
    // initiate tab
    tabController = TabController(length: 3, initialIndex: 1, vsync: this);
    if (kDebugMode && contractPk == null) {
      // for development purpose, retrieve first data
      contractPk = LdvDetailPk().findAll()[0];
    }
    // load existing
    if (contractPk != null) {
      initialValue(TrnRVCollComment().findByContractNo(contractPk!.contractNo!));
    }
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  @override
  Future<bool> submit() async {
    if (!await super.submit()) return false;
    if (submitting.isTrue) {
      log('Waiting for submitting...');
      return false;
    }

    submitting(true);
    try {
      //  ...
      // check permissions again
      if (!await validateAllPermissions()) {
        showError('Maaf, Anda harus menyetujui akses ke perangkat.');
        return false;
      }

      // finally, upload data
      log('upload assignment');

      dataChanged(false);
      // finally, update cache
      // Navigator.pop(Get.context!, [resp]);
      return true;
    } catch (e, s) {
      if (e is DioException && e.response?.statusCode == 403) {
        AuthController.instance.logout();
        throw Exception('Session Timeout. please relogin');
      }
      showError(e, stacktrace: s);
    } finally {
      submitting(false);
    }
    return false;
  }
}
