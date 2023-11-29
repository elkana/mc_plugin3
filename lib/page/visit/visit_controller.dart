import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/auth_controller.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import 'package:mc_plugin3/util/commons.dart';
import 'package:mc_plugin3/util/ldv_util.dart';

import '../../controller/aformbuilder_controller.dart';
import '../../model/trn_ldv_hdr.dart';
import '../../routes/app_routes.dart';

class VisitBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<VisitController>(() => VisitController());
}

class VisitController extends ATabFormController with GetSingleTickerProviderStateMixin {
  LdvDetailPk? contractPk;
  var initialValue = Rxn<TrnRVCollComment>();

  static show(OTrnLdvDetail data) async {
    // jika ada transaksi di rvcollcomment, skip poa
    var visited = TrnRVCollComment().findByContractNo(data.pk?.contractNo);
    if (visited == null) {
      var poaData = await Get.toNamed(Routes.poa, arguments: [
        data.pk
      ], parameters: {
        // 'id': e.sktNo!,
        // 'visitId': visitId,
      });
      if (poaData == null) return;
    }
    Get.toNamed(Routes.visit);
  }

  @override
  void onInit() {
    super.onInit();
    // initiate tab
    tabController = TabController(length: 3, initialIndex: 1, vsync: this);
    if (kDebugMode && contractPk == null) {
      // for development purpose, retrieve first data
      contractPk = LdvDetailPk().findAll()[0];
    }
    // load form data
    if (contractPk != null) {
      initialValue(TrnRVCollComment().findByContractNo(contractPk!.contractNo!));
    } else {
      throw Exception('A Valid Contract Required.');
    }
  }

  @override
  Future onSubmit() async {
    var formData = TrnRVCollComment.fromMap(formKey.currentState!.value)
      ..rvCollNo ??= LdvUtil.generateRVCollNo(
          OTrnLdvHeader().findByPk(contractPk!.ldvNo!)!.ldvDate!.isoToLocalDate(), AuthController.instance.loggedUserId)
      ..lkpNo = contractPk?.ldvNo
      ..contractNo = contractPk?.contractNo;
    var merge = initialValue.value?.toMap()
      ?..addAll(formData.toMap()); // merge will be null if initialValue is also null no matter what
    var saved = await TrnRVCollComment().saveOrUpdate(merge != null ? TrnRVCollComment.fromMap(merge) : formData);

    // finally, upload data
    log('upload assignment $saved');
    await 1.delay().then((_) => Navigator.pop(Get.context!, [saved]));
  }
}
