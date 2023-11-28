import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/util/hive_util.dart';

import '../../controller/abasic_controller.dart';
import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../../provider/api.dart';
import '../../routes/app_routes.dart';

class LdvListBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LdvListController>(() => LdvListController());
}

class LdvListController extends ABasicController {
  final scrollAktif = ScrollController();

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  Future refreshData() => processThis(() => Api.instance.assignments);

  Future onVisit(OTrnLdvDetail data) async {
    // showToast('Visiting $data');
    await Get.toNamed(Routes.poa, arguments: [
      data.pk
      // data.pk!.ldvNo, data.pk!.contractNo,
      // inbound
      // TblSKTHeader.findById(e.sktNo),
      // poa,
    ], parameters: {
      // 'id': e.sktNo!,
      // 'visitId': visitId,
    });
  }

  Future resetData() async {
    await HiveUtil.cleanAll(true);
    await refreshData();
  }
}
