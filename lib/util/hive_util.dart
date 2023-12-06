import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';
import 'package:path_provider/path_provider.dart';

import '../model/masters.dart';
import '../model/mc_trn_rvcollcomment.dart';
import '../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
// const darkModeBox = 'darkModeConfig';

bool isNullOrZero(int? value) => value == null || value < 1;
changeTime(DateTime src, int hour, int minute, int seconds) =>
    DateTime(src.year, src.month, src.day, hour, minute, seconds, 0, 0);

class HiveUtil {
  // masters
  static const typeIdMstMobileSetup = 0;
  static const typeIdMstOffice = 1;
  static const typeIdMstTaskType = 2;
  static const typeIdMstUserRole = 3;
  static const typeIdMstLdvClassification = 4;
  static const typeIdMstLdvDelqReason = 5;
  static const typeIdMstLdvFlag = 6;
  static const typeIdMstLdvNextAction = 7;
  static const typeIdMstPersonal = 8;
  static const typeIdMstLdvPotensi = 9;
  static const typeIdMstLdvStatus = 10;
  static const typeIdMstLdvDocument = 11;
  static const typeIdMstBank = 15;
  static const typeIdMstPaymentPoint = 16;

  static const typeIdTrnLdvHeaderOutbound = 100;
  static const typeIdTrnLdvHeaderInbound = 101;
  static const typeIdTrnLdvDetailPK = 102;
  static const typeIdTrnLdvDetailOutbound = 103;
  static const typeIdTrnLdvDetailInbound = 104;
  static const typeIdTrnRVCollComment = 105;
  static const typeIdTrnAddress = 106;
  static const typeIdTrnRvb = 107;
  static const typeIdTrnDeposit = 108;
  static const typeIdTrnPhoto = 109;
  static const typeIdTrnRepo = 110;
  static const typeIdTrnBastbj = 111;
  static const typeIdTrnContractBucket = 112;
  static const typeIdTrnChangeAddr = 113;
  static const typeIdTrnVehicleInfo = 114;
  static const typeIdTrnHistInstallment = 115;
  static const typeIdLdvHistory = 116;

  static const typeIdDocCopyContract = 200;
  static const typeIdDocSP = 201;
  static const typeIdDocSKTAsset = 202;
  static const typeIdDocSKTCollateral = 203;
  static const typeIdDocSKTHeader = 204;

  // common
  static const typeIdMessage = 20;
  static const typeIdUserData = 21;
  static const typeIdAbsensi = 22;
  static const typeIdTransferCash2BankLog = 23;
  // spv
  static const typeIdCollJob = 30;

  static const typeIdSyncTable = 88; // reserved

  static bool emptyOfficesAllowed = false,
      emptyPaymentPointsAllowed = false,
      emptyBanksAllowed = false,
      emptyStatusAllowed = false,
      emptyFlagsAllowed = false,
      emptyClassificationsAllowed = false,
      emptyDelqReasonsAllowed = false,
      emptyPotensisAllowed = false,
      emptyNextActionsAllowed = false,
      emptyTaskTypesAllowed = false,
      emptyPaymentPatternsAllowed = false,
      emptyResultCategoriesAllowed = false,
      emptyPersonalsAllowed = false,
      emptyDocumentsAllowed = false;

  static Future registerAdaptersFirstTime() async {
    if (!kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    // Hive.registerAdapter(MstMobileSetupAdapter());
    // Hive.registerAdapter(MstOfficeAdapter());
    // Hive.registerAdapter(MstTaskTypeAdapter());
    // Hive.registerAdapter(MstUserRoleAdapter());
    Hive.registerAdapter(MstLdvClassificationAdapter());
    Hive.registerAdapter(MstLdvDelqReasonAdapter());
    // Hive.registerAdapter(MstLdvFlagAdapter());
    Hive.registerAdapter(MstLdvNextActionAdapter());
    Hive.registerAdapter(MstLdvPersonalAdapter());
    // Hive.registerAdapter(MstLdvPotensiAdapter());
    // Hive.registerAdapter(MstLdvStatusAdapter());
    // Hive.registerAdapter(MstLDVDocumentAdapter());
    // Hive.registerAdapter(MstBankAdapter());
    // Hive.registerAdapter(MstPaymentPointAdapter());

    // Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(OTrnLdvHeaderAdapter());
    Hive.registerAdapter(ITrnLdvHeaderAdapter());
    Hive.registerAdapter(OTrnLdvDetailAdapter());
    Hive.registerAdapter(ITrnLdvDetailAdapter());
    Hive.registerAdapter(LdvDetailPkAdapter());
    Hive.registerAdapter(TrnRVCollCommentAdapter());
    // Hive.registerAdapter(TrnAddressAdapter());
    // Hive.registerAdapter(TrnRVBAdapter());
    // Hive.registerAdapter(TrnDepositAdapter());
    // Hive.registerAdapter(TrnPhotoAdapter());
    // Hive.registerAdapter(TrnRepoAdapter());
    // Hive.registerAdapter(TrnBastbjAdapter());
    // Hive.registerAdapter(TrnContractBucketAdapter());
    // Hive.registerAdapter(TrnChangeAddrAdapter());
    // Hive.registerAdapter(TrnVehicleInfoAdapter());
    // Hive.registerAdapter(TrnHistInstallmentAdapter());
    // Hive.registerAdapter(LdvHistoryAdapter());
    // Hive.registerAdapter(TransferCash2BankLogAdapter());
    // Hive.registerAdapter(DocCopyContractAdapter());
    // Hive.registerAdapter(DocSPAdapter());
    // Hive.registerAdapter(DocSKTAssetAdapter());
    // Hive.registerAdapter(DocSKTCollateralAdapter());
    // Hive.registerAdapter(DocSKTHeaderAdapter());

    // Hive.registerAdapter(SyncTrnTableAdapter());
    //add more here

    // await Hive.openBox<MstMobileSetup>(MstMobileSetup.syncTableName);
    // await Hive.openBox<MstTaskType>(MstTaskType.syncTableName);
    // await Hive.openBox<MstUserRole>(MstUserRole.syncTableName);
    // await Hive.openBox<MstOffice>(MstOffice.syncTableName);
    await Hive.openBox<MstLdvClassification>(MstLdvClassification().syncTableName);
    await Hive.openBox<MstLdvDelqReason>(MstLdvDelqReason().syncTableName);
    // await Hive.openBox<MstLdvFlag>(MstLdvFlag.syncTableName);
    await Hive.openBox<MstLdvNextAction>(MstLdvNextAction().syncTableName);
    await Hive.openBox<MstLdvPersonal>(MstLdvPersonal().syncTableName);
    // await Hive.openBox<MstLdvPotensi>(MstLdvPotensi.syncTableName);
    // await Hive.openBox<MstLdvStatus>(MstLdvStatus.syncTableName);
    // await Hive.openBox<MstLDVDocument>(MstLDVDocument.syncTableName);
    // await Hive.openBox<MstBank>(MstBank.syncTableName);
    // await Hive.openBox<MstPaymentPoint>(MstPaymentPoint.syncTableName);
    // await Hive.openBox<UserData>(UserData.syncTableName);

    await Hive.openBox<OTrnLdvHeader>(OTrnLdvHeader().syncTableName);
    await Hive.openBox<ITrnLdvHeader>(ITrnLdvHeader().syncTableName);
    await Hive.openBox<OTrnLdvDetail>(OTrnLdvDetail().syncTableName);
    await Hive.openBox<ITrnLdvDetail>(ITrnLdvDetail().syncTableName);
    await Hive.openBox<LdvDetailPk>(LdvDetailPk().syncTableName);
    await Hive.openBox<TrnRVCollComment>(TrnRVCollComment().syncTableName);
    // await Hive.openBox<TrnAddress>(TrnAddress.syncTableName);
    // await Hive.openBox<TrnRVB>(TrnRVB.syncTableName);
    // await Hive.openBox<TrnDeposit>(TrnDeposit.syncTableName);
    // await Hive.openBox<TrnPhoto>(TrnPhoto.syncTableName);
    // await Hive.openBox<TrnRepo>(TrnRepo.syncTableName);
    // await Hive.openBox<TrnBastbj>(TrnBastbj.syncTableName);
    // await Hive.openBox<TrnContractBucket>(TrnContractBucket.syncTableName);
    // await Hive.openBox<TrnChangeAddr>(TrnChangeAddr.syncTableName);
    // await Hive.openBox<TrnVehicleInfo>(TrnVehicleInfo.syncTableName);
    // await Hive.openBox<TrnHistInstallment>(TrnHistInstallment.syncTableName);
    // await Hive.openBox<LdvHistory>(LdvHistory.syncTableName);
    // await Hive.openBox<TransferCash2BankLog>(TransferCash2BankLog.syncTableName);

    // await Hive.openBox<DocCopyContract>(DocCopyContract.syncTableName);
    // await Hive.openBox<DocSP>(DocSP.syncTableName);
    // await Hive.openBox<DocSKTAsset>(DocSKTAsset.syncTableName);
    // await Hive.openBox<DocSKTCollateral>(DocSKTCollateral.syncTableName);
    // await Hive.openBox<DocSKTHeader>(DocSKTHeader.syncTableName);

    // await Hive.openBox<SyncTrnTable>(SyncTrnTable.syncTableName);
    //add more here
  }

  static Future cleanAll(bool cleanMaster) async {
    if (cleanMaster) await cleanMastersOnly();

    await Future.wait([
      // MstTaskType.cleanAll(),
      // MstUserRole.cleanAll(),
      // MstOffice.cleanAll(),
      // UserData.cleanAll(),

      cleanMastersOnly(),
      cleanTransactionsOnly(),
      //add more here
    ]);
  }

  static Future cleanMastersOnly() => Future.wait([
        // MstMobileSetup.cleanAll(),
        MstLdvClassification().cleanAll(),
        MstLdvDelqReason().cleanAll(),
        // MstLdvFlag.cleanAll(),
        MstLdvNextAction().cleanAll(),
        MstLdvPersonal().cleanAll(),
        // MstLdvPotensi.cleanAll(),
        // MstLdvStatus.cleanAll(),
        // MstBank.cleanAll(),
        // MstPaymentPoint.cleanAll(),
        //add more here
      ]);

  static Future cleanTransactionsOnly() => Future.wait([
        // SyncTrnTable.cleanAll(),
        OTrnLdvHeader().cleanAll(),
        ITrnLdvHeader().cleanAll(),
        LdvDetailPk().cleanAll(),
        OTrnLdvDetail().cleanAll(),
        ITrnLdvDetail().cleanAll(),
        // Pk.cleanAll(),
        TrnRVCollComment().cleanAll(),
        // TrnAddress.cleanAll(),
        // TrnRVB.cleanAll(),
        // TrnDeposit.cleanAll(),
        // TrnPhoto.cleanAll(),
        // TrnRepo.cleanAll(),
        // TrnBastbj.cleanAll(),
        // TrnContractBucket.cleanAll(),
        // TrnChangeAddr.cleanAll(),
        // TrnVehicleInfo.cleanAll(),
        // TrnHistInstallment.cleanAll(),
        // TransferCash2BankLog.cleanAll(),
        // LdvHistory.cleanAll(),

        // DocSP.cleanAll(),
        // DocCopyContract.cleanAll(),
        // DocSKTAsset.cleanAll(),
        // DocSKTHeader.cleanAll(),
        // DocSKTCollateral.cleanAll(),
        //add more here
      ]);

  // static isMasterEmpty() =>
  //     MstMobileSetup.isEmpty() ||
  //     (MstLdvClassification.isEmpty() && !emptyClassificationsAllowed) ||
  //     (MstLdvDelqReason.isEmpty() && !emptyDelqReasonsAllowed) ||
  //     (MstLdvFlag.isEmpty() && !emptyFlagsAllowed) ||
  //     (MstLdvNextAction.isEmpty() && !emptyNextActionsAllowed) ||
  //     (MstLdvPersonal.isEmpty() && !emptyPersonalsAllowed) ||
  //     (MstLdvPotensi.isEmpty() && !emptyPotensisAllowed) ||
  //     (MstBank.isEmpty() && !emptyBanksAllowed) ||
  //     (MstPaymentPoint.isEmpty() && !emptyPaymentPointsAllowed) ||
  //     (MstLdvStatus.isEmpty() && !emptyStatusAllowed);
}

// abstract class MasterTable<T> extends HiveObject {
//   final String syncTableName;
//   MasterTable(this.syncTableName);

//   bool comparePrimaryKey(T a, T b);
//   Map<String, dynamic> toMap();

//   String toJson() => json.encode(toMap());

//   // this will clear data and refill
//   Future<void> assignAll(List<T>? data) async {
//     if (data == null) return;
//     await cleanAll();

//     final box = Hive.box<T>(syncTableName);
//     for (var d in data) {
//       box.add(d);
//     }
//   }

//   Future cleanAll() async {
//     debugPrint('cleanup $syncTableName');
//     final box = Hive.box<T>(syncTableName);
//     await box.clear();
//   }

//   List<T> findAll() {
//     final box = Hive.box<T>(syncTableName);
//     List<T> list = box.values.toList().cast<T>();
//     return list;
//   }
// }

abstract class LocalTable<T> extends HiveObject {
  final String syncTableName;

  LocalTable(this.syncTableName);

  // T? findByPk(bool Function(T) test);
  bool comparePk(T a, T b);
  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());

  get listenTable => Hive.box<T>(syncTableName).listenable();

  Future cleanAll() async {
    debugPrint('cleanup $syncTableName');
    final box = Hive.box<T>(syncTableName);
    await box.clear();
  }

  //  {
  //   final list = findAll();
  //   if (list.isEmpty) return null;
  //   try {
  //     return list.where((element) => false)
  //   } catch (e) {
  //     return null;
  //   }
  // }

  List<T> findAll() {
    final box = Hive.box<T>(syncTableName);
    List<T> list = box.values.toList().cast<T>();
    return list;
  }

  // this will clear data and refill
  Future<List<T>> assignAll(List<T>? data) async {
    await cleanAll();
    return saveAll(data);
  }

  // T? findById(int? key) {
  //   List<T> list = findAll();
  //   if (list.isEmpty) return null;
  //   try {
  //     return list.where((e) => (e as HiveObject).key == key).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<List<T>> saveAll(List<T>? origin) async {
    if (null == origin || origin.isEmpty) return [];
    var list = origin.where((e) => true).toList();
    // log('RECEIVE ${list.length} $syncTableName');
    for (var e in list) {
      await saveOne(e);
    }
    return list;
  }

// WARNING !! column id must provided/available
  Future<T> saveOne(T origin) async {
    final box = Hive.box<T>(syncTableName);
    final Map<dynamic, T> map = box.toMap();

    int? desiredKey;
    map.forEach((key, value) {
      if (comparePk(value, origin)) {
        desiredKey = key;
      }
    });
    debugPrint('$syncTableName ${desiredKey == null ? 'INSERT' : 'UPDATE(id=$desiredKey)'} $origin');
    desiredKey ??= await box.add(origin);
    // need to reuse id for sync purpose
    (origin as dynamic).id = desiredKey!;
    await box.put(desiredKey, origin);

    return origin;
  }
}
