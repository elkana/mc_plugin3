import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/aformbuilder_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../../../util/commons.dart';
import '../../../util/time_util.dart';

class LdvDetilBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LdvDetilController>(() => LdvDetilController());
}

// receive 2 args: ldvNo & contractNo
// to determine which Outbound or Inbound data
class LdvDetilController extends AFormBuilderController with GetSingleTickerProviderStateMixin {
  static LdvDetilController instance = Get.find();
  late LdvDetailPk pk;
  late OTrnLdvDetail outbound;
  ITrnLdvDetail? inbound;
  // berisi foto yg belum disync aja ?
  // intinya supaya ga perlu write ke table kalau belum final, shg ga perlu cleanup
  // var photoList = <TblPhoto>[].obs;
  // var formCollateralWidgets = <FormCollateralCard>[].obs;
  // // krn ovd dyas yg melebihi bbrp hari, success current ditiadakan
  // var lovRepoStatus = <String>[].obs;
  // var repoStatus = ''.obs; // will be listened by children
  // late String visitId;
  // TabController? tabController;

  // FormBuilderFieldState? get selectedExtendStatus => formKey.currentState?.fields['extendStatus'];
  // FormBuilderFieldState? get selectedRepoStatus => formKey.currentState?.fields['repoStatus'];

  @override
  void onInit() {
    super.onInit();

    try {
      pk = Get.arguments[0];

      outbound = OTrnLdvDetail().findByPk(pk.ldvNo!, pk.contractNo!)!;
      inbound = ITrnLdvDetail().findByPk(pk.ldvNo!, pk.contractNo!);
      // visitId = Get.parameters['visitId'] ?? PhotoUtil.generateVisitId();
    } catch (e, s) {
      log(e.toString(), stacktrace: s);
      if (kDebugMode) {
        // this mode requires offline data. so you need to pull it first on positif test.
        // initialValue = TblSKTHeader.findAll().first;
        // visitId = PhotoUtil.generateVisitId();
      }
    }
  }

  @override
  Future onSubmit() async {
    log('Form-> ${formKey.currentState?.value}');
    var offlineData = ITrnLdvDetail()
      ..pk = pk
      ..custName = outbound.custName
      ..workStatus = formKey.currentState!.value['workStatus']
      ..createdBy = AuthController.instance.loggedUserId
      ..createdDate = TimeUtil.nowIso();

    var saved = await ITrnLdvDetail().saveOne(offlineData);

    await 1.delay().then((_) => Navigator.pop(Get.context!, [saved]));
  }
}
