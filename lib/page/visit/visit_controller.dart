import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/auth_controller.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import 'package:mc_plugin3/util/commons.dart';
import 'package:mc_plugin3/util/customs.dart';
import 'package:mc_plugin3/util/ldv_util.dart';

import '../../controller/aformbuilder_controller.dart';
import '../../controller/pref_controller.dart';
import '../../model/trn_ldv_hdr.dart';
import '../../routes/app_routes.dart';

class VisitBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<VisitController>(() => VisitController());
}

class VisitController extends ATabFormController with GetSingleTickerProviderStateMixin {
  LdvDetailPk? contractPk;
  var initialValue = Rxn<TrnRVCollComment>();
  TrnRVCollComment get formObject => TrnRVCollComment.fromMap(formKey.currentState!.value);

  // need both param because this method can be called by outbound/inbound
  static show(String ldvNo, String contractNo) async {
    sessionStop();
    // jika ada transaksi di rvcollcomment, skip poa
    var visited = TrnRVCollComment().findByContractNo(contractNo);
    if (visited == null) {
      var poaData = await Get.toNamed(Routes.poa, arguments: [ldvNo, contractNo]);
      if (poaData == null) return;
    }
    await Get.toNamed(Routes.visit);
    if (kReleaseMode) clientLogic?.sync;
    sessionStart();
  }
  // static show(OTrnLdvDetail data) async {
  //   sessionStop();
  //   // jika ada transaksi di rvcollcomment, skip poa
  //   var visited = TrnRVCollComment().findByContractNo(data.pk?.contractNo);
  //   if (visited == null) {
  //     var poaData = await Get.toNamed(Routes.poa, arguments: [data]);
  //     if (poaData == null) return;
  //   }
  //   await Get.toNamed(Routes.visit);
  //   if (kReleaseMode) clientLogic?.sync;
  //   sessionStart();
  // }

  @override
  void onInit() {
    super.onInit();
    // initiate 3 tabs for: detail, kronologi & penerimaan
    tabController = TabController(length: 3, initialIndex: 1, vsync: this);
    if (kDebugMode && contractPk == null) {
      // for development purpose, retrieve first data
      contractPk = LdvDetailPk().findAll[0];
    }
    if (contractPk == null) throw Exception('A Valid Contract Required.');
    // load form data
    var existingTrnRVColl = TrnRVCollComment().findByContractNo(contractPk!.contractNo!);
    initialValue(existingTrnRVColl);
    formEnabled = existingTrnRVColl == null;
  }

  @override
  Future onSubmit() async {
    var oContract = OTrnLdvDetail().findByPk(contractPk!.ldvNo!, contractPk!.contractNo!);

    // 1. convert from form data back to trnrvcollcomment
    RvCollPk pk = RvCollPk()
      ..rvCollNo ??= LdvUtil.generateRVCollNo(
          OTrnLdvHeader().findByPk(contractPk!.ldvNo!)!.ldvDate!.isoToLocalDate(), AuthController.instance.loggedUserId)
      ..contractNo = contractPk?.contractNo;

    var formData = formObject
      ..pk = pk
      ..ldvNo = contractPk?.ldvNo;

    // 1.a. save new pk of rvcoll
    await RvCollPk().saveOne(pk);
    // merge rvcoll using map trick
    // var mergeMap = initialValue.value?.toMap()?..addAll(formData.toMap()); not useful
    // 1.b. save rvcoll
    // var record = await TrnRVCollComment().saveOne(TrnRVCollComment.fromMap(mergeMap!));
    var record = await TrnRVCollComment().saveOne(formData);

    // 2. save as inbound
    await ITrnLdvDetail().saveOne(ITrnLdvDetail()
      ..pk = contractPk
      ..workStatus = 'V'
      ..custName = oContract?.custName
      ..createdBy = AuthController.instance.loggedUserId);

    // return with back saved data
    await 1.delay().then((_) => Navigator.pop(Get.context!, [record]));
  }
}
