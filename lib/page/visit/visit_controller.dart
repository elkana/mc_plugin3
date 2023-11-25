import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/abasic_controller.dart';
import 'package:mc_plugin3/model/trn_lkp_dtl/o_trn_lkp_dtl.dart';

class VisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitController>(() => VisitController());
  }
}

class VisitController extends ABasicController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  LdvDetailPk? contractPk;
  var bertemuDengan = ''.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, initialIndex: 1, vsync: this);
    if (kDebugMode && contractPk == null) {
      contractPk = LdvDetailPk.findAll()[0];
    }
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
