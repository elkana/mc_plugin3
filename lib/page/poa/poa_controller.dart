import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/abasic_controller.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/o_trn_ldv_dtl.dart';

import '../../routes/app_routes.dart';
import '../../util/device_util.dart';
import '../../util/photo_util.dart';

class PoaBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<PoaController>(() => PoaController());
}

// argument 0 = ldvNo
// argument 1 = contractNo
class PoaController extends ABasicController {
  late OutboundLdvDetail contract;
  final msgMain = 'Ambil foto saat Anda telah tiba di lokasi';

  @override
  void onInit() {
    super.onInit();
    contract = OutboundLdvDetail().findByPk(Get.arguments[0], Get.arguments[1])!;
    ever<bool>(loading, (callback) => progressMsg(callback ? 'Tunggu sebentar...' : msgMain));
  }

  Future takePhoto() async {
    if (loading.isTrue) return;
    if (!await DeviceUtil.allPermissionsGranted()) return;
    return await processThis(() async {
      var file = await PhotoUtil.takePhotoGeneric();
      if (null == file) return;

      // visitId nantinya akan dipakai utk link dengan collateralremarks, krn tiap remarks memerlukan PoA
      var visitId = PhotoUtil.generateVisitId();
      // var poa = await PhotoUtil.xFileToPhoto(
      //     file, PhotoType.repoPoA, PhotoUtil.concatVisitIdWithSktNo(sktHeader.sktNo!, visitId), sktHeader.contractNo!);
      // karena fitur ini bisa dicancel jadi ga perlu dismpan ke table, sehingga harus balikin koordinat dan file photonya
      try {
        // before back, better refresh data skt here
        progressMsg('Memperbarui data...');
        // await DataUtil.getAssignment(sktHeader.sktNo);
      } catch (e) {}
      // return new foto
      Navigator.of(Get.context!).pop('ok');
    });
  }
}
