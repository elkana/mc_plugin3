import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mc_plugin3/controller/auth_controller.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import 'package:mc_plugin3/provider/mediaapi.dart';
import 'package:mc_plugin3/util/commons.dart';
import 'package:mc_plugin3/util/customs.dart';
import 'package:mc_plugin3/util/ldv_util.dart';
import 'package:mc_plugin3/util/photo_util.dart';

import '../../controller/aformbuilder_controller.dart';
import '../../controller/pref_controller.dart';
import '../../model/mc_photo.dart';
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
  String? imageUri;
  // Q: apakah jmlnya fotoList sama dengan trntable ?
  // A: tidak, krn widget PhotoFrame akan otomatis cari di server terlebih dulu
  // jadi fotoList hanya utk menambah foto baru saja
  final List<TrnPhoto> fotoList = [];

  // need both param because this method can be called by outbound/inbound
  static show(String ldvNo, String contractNo) async {
    sessionStop();
    // jika ada transaksi di rvcollcomment, skip poa
    if (TrnRVCollComment().findByContractNo(contractNo) == null) {
      // if nothing return from PoA, abort
      if (await Get.toNamed(Routes.poa, arguments: [ldvNo, contractNo]) == null) return;
    }
    await Get.toNamed(Routes.visit);
    // sync whenever possible
    if (kReleaseMode) clientLogic?.sync;
    sessionStart();
  }

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
    initialValue(TrnRVCollComment().findByContractNo(contractPk!.contractNo!)); // formEnabled = existing == null;

    PrefController.instance.lastSelectedServer.then((v) {
      imageUri = MediaApi.getImageUri(v!);
      update();
    });
  }

  @override
  Future onSubmit() async {
    // commit fotoList to table TrnPhoto
    await TrnPhoto().saveAll(fotoList);
    // 1. prepare Pk
    var pk = RvCollPk()
      ..rvCollNo ??= LdvUtil.generateRVCollNo(
          OutboundLdvHeader().findByPk(contractPk!.ldvNo!)!.ldvDate!.isoToLocalDate(),
          AuthController.instance.loggedUserId)
      ..contractNo = contractPk?.contractNo;

    // 2.a. save new pk of rvcoll
    await RvCollPk().saveOne(pk);
    // 2.b. save rvcoll
    var record = await TrnRVCollComment().saveOne(formObject
      ..pk = pk
      ..ldvNo = contractPk?.ldvNo);

    // 3. save as inbound
    await InboundLdvDetail().saveOne(InboundLdvDetail()
      ..pk = contractPk
      ..workStatus = 'V'
      ..custName = OutboundLdvDetail().findByPk(contractPk!.ldvNo!, contractPk!.contractNo!)?.custName
      ..createdBy = AuthController.instance.loggedUserId);

    // 4. return with new record
    await 1.delay().then((_) => Navigator.pop(Get.context!, [record]));
  }

  Future addFoto(XFile file, PhotoType as) async {
    var foto = await PhotoUtil.xFileToPhoto(file, as, '${contractPk!.ldvNo}', contractPk!.contractNo!);
    int idx = fotoList.indexWhere((p) => p.sourceId == foto.sourceId && p.photoId == foto.photoId);
    if (idx < 0) {
      fotoList.add(foto);
    } else {
      fotoList[idx] = foto;
    }
    update();
  }

  // needed by kronologi_view.dart without using future
  String? getFotoUrl(PhotoType as) => imageUri == null
      ? null
      : PhotoUtil.getLink(imageUri!, contractPk!.ldvNo, as.fileKey,
          orElseUseBlobPath: fotoList
              .firstWhereOrNull((p) =>
                  p.photoId == as.fileKey &&
                  p.userId == AuthController.instance.loggedUserId &&
                  p.sourceId == contractPk!.ldvNo)
              ?.blobPath);
}
