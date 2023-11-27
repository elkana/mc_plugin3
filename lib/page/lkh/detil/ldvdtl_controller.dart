import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/trn_lkp_dtl/o_trn_lkp_dtl.dart';
import 'package:mc_plugin3/util/time_util.dart';

import '../../../controller/aformbuilder_controller.dart';
import '../../../controller/auth_controller.dart';
import '../../../model/trn_lkp_dtl/i_trn_lkp_dtl.dart';
import '../../../util/commons.dart';

class LdvDetilBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LdvDetilController>(() => LdvDetilController());
}

// receive 2 args: ldvNo & contractNo
// to determine which Outbound or Inbound data
class LdvDetilController extends AFormBuilderController with GetSingleTickerProviderStateMixin {
  static LdvDetilController instance = Get.find();
  late LdvDetailPk pk;
  late OTrnLKPDetail outbound;
  ITrnLKPDetail? inbound;
  var submitting = false.obs;
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

      outbound = OTrnLKPDetail().findByPk(pk.ldvNo!, pk.contractNo!)!;
      inbound = ITrnLKPDetail().findByPk(pk.ldvNo!, pk.contractNo!);
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

  Future<ITrnLKPDetail> _buildData() async {
    log('Form-> ${formKey.currentState?.value}');
    var offlineData = ITrnLKPDetail()
      ..pk = pk
      ..custName = outbound.custName
      ..workStatus = formKey.currentState!.value['workStatus']
      ..createdBy = AuthController.instance.loggedUserId
      ..createdDate = TimeUtil.nowIso();
    return offlineData;
  }

  @override
  Future<bool> submit() async {
    if (!await super.submit()) return false;
    var error = false;
    if (!(formKey.currentState?.saveAndValidate() ?? false)) {
      log('validation FAILED form skt detail ${formKey.currentState?.value}');
      error = true;
    }
    if (error) return false;
    submitting(true);
    try {
      var saved = await ITrnLKPDetail().saveOrUpdate(await _buildData());
      //upload all photo

      // finally, upload data
      log('upload assignment');
      // var resp = await Api.instance.updateAssignment(ResponseAssignment()
      //   ..header = sktHeader
      //   ..collateralRemarks = newRemarks);
      // log('Response Submit $resp');
      dataChanged(false);
      // finally, update cache
      // DataUtil.getAssignment(sktHeader.sktNo);
      await 1.delay().then((_) => Navigator.pop(Get.context!, [saved]));

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
