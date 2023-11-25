import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../model/master/mst_personal.dart';
import '../model/mc_trn_lkp_hdr.dart';
import '../model/trn_lkp_dtl/i_trn_lkp_dtl.dart';
import '../model/trn_lkp_dtl/o_trn_lkp_dtl.dart';
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

  static const typeIdTrnLdvHeader = 100;
  static const typeIdTrnLdvDetailPK = 101;
  static const typeIdTrnLdvDetailOutbound = 102;
  static const typeIdTrnLdvDetailInbound = 103;
  static const typeIdTrnRVCollComment = 104;
  static const typeIdTrnAddress = 105;
  static const typeIdTrnRvb = 106;
  static const typeIdTrnDeposit = 107;
  static const typeIdTrnPhoto = 108;
  static const typeIdTrnRepo = 109;
  static const typeIdTrnBastbj = 110;
  static const typeIdTrnContractBucket = 111;
  static const typeIdTrnChangeAddr = 112;
  static const typeIdTrnVehicleInfo = 113;
  static const typeIdTrnHistInstallment = 114;
  static const typeIdLdvHistory = 115;

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
    // Hive.registerAdapter(MstLdvClassificationAdapter());
    // Hive.registerAdapter(MstLdvDelqReasonAdapter());
    // Hive.registerAdapter(MstLdvFlagAdapter());
    // Hive.registerAdapter(MstLdvNextActionAdapter());
    Hive.registerAdapter(MstPersonalAdapter());
    // Hive.registerAdapter(MstLdvPotensiAdapter());
    // Hive.registerAdapter(MstLdvStatusAdapter());
    // Hive.registerAdapter(MstLDVDocumentAdapter());
    // Hive.registerAdapter(MstBankAdapter());
    // Hive.registerAdapter(MstPaymentPointAdapter());

    // Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(TrnLKPHeaderAdapter());
    Hive.registerAdapter(OTrnLKPDetailAdapter());
    Hive.registerAdapter(ITrnLKPDetailAdapter());
    Hive.registerAdapter(LdvDetailPkAdapter());
    // Hive.registerAdapter(TrnRVCollCommentAdapter());
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
    // await Hive.openBox<MstLdvClassification>(MstLdvClassification.syncTableName);
    // await Hive.openBox<MstLdvDelqReason>(MstLdvDelqReason.syncTableName);
    // await Hive.openBox<MstLdvFlag>(MstLdvFlag.syncTableName);
    // await Hive.openBox<MstLdvNextAction>(MstLdvNextAction.syncTableName);
    await Hive.openBox<MstPersonal>(MstPersonal().syncTableName);
    // await Hive.openBox<MstLdvPotensi>(MstLdvPotensi.syncTableName);
    // await Hive.openBox<MstLdvStatus>(MstLdvStatus.syncTableName);
    // await Hive.openBox<MstLDVDocument>(MstLDVDocument.syncTableName);
    // await Hive.openBox<MstBank>(MstBank.syncTableName);
    // await Hive.openBox<MstPaymentPoint>(MstPaymentPoint.syncTableName);
    // await Hive.openBox<UserData>(UserData.syncTableName);

    await Hive.openBox<TrnLKPHeader>(TrnLKPHeader.syncTableName);
    await Hive.openBox<OTrnLKPDetail>(OTrnLKPDetail.syncTableName);
    await Hive.openBox<ITrnLKPDetail>(ITrnLKPDetail.syncTableName);
    await Hive.openBox<LdvDetailPk>(LdvDetailPk.syncTableName);
    // await Hive.openBox<TrnRVCollComment>(TrnRVCollComment.syncTableName);
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

  static Future cleanMastersOnly() async {
    await Future.wait([
      // MstMobileSetup.cleanAll(),
      // MstLdvClassification.cleanAll(),
      // MstLdvDelqReason.cleanAll(),
      // MstLdvFlag.cleanAll(),
      // MstLdvNextAction.cleanAll(),
      MstPersonal().cleanAll(),
      // MstLdvPotensi.cleanAll(),
      // MstLdvStatus.cleanAll(),
      // MstBank.cleanAll(),
      // MstPaymentPoint.cleanAll(),
      //add more here
    ]);
  }

  static Future cleanTransactionsOnly() => Future.wait([
        // SyncTrnTable.cleanAll(),
        TrnLKPHeader.cleanAll(),
        LdvDetailPk.cleanAll(),
        OTrnLKPDetail.cleanAll(),
        ITrnLKPDetail.cleanAll(),
        // Pk.cleanAll(),
        // TrnRVCollComment.cleanAll(),
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

// TODO trouble initialize syncTableName, too much waste time
abstract class LocalTable<T> extends HiveObject {
  abstract final String syncTableName;

  bool onPKCheck(T a, T b);

  // @HiveField(0)
  // int? id;

  // LocalTable._(this.syncTableName);

  // Future flush(List<T>? data) async {
  //   if (data == null) return;
  //   final box = Hive.box<T>(syncTableName);
  //   await box.clear();
  //   for (var d in data) {
  //     box.add(d);
  //   }
  //   debugPrint('flushed ${box.values.toList().length} $syncTableName');
  // }

  Future cleanAll() async {
    debugPrint('cleanup $syncTableName');
    final box = Hive.box<T>(syncTableName);
    await box.clear();
  }

  List<T> findAll() {
    final box = Hive.box<T>(syncTableName);
    List<T> list = box.values.toList().cast<T>();
    return list;
  }

  T? findById(int? key) {
    List<T> list = findAll();
    if (list.isEmpty) return null;
    try {
      return list.where((e) => (e as HiveObject).key == key).first;
    } catch (e) {
      return null;
    }
  }

  Future<List<T>> saveOrUpdateAll(List<T>? origin) async {
    if (null == origin) return [];
    var list = origin.where((e) => true).toList();
    // log('RECEIVE ${list.length} $syncTableName');
    for (var e in list) {
      await saveOrUpdate(e);
    }
    return list;
  }

  Future<T> saveOrUpdate(T origin
      // bool Function(T, T origin) onPKCheck,
      /*Function(T, int insertedKey) onInsert*/
      ) async {
    final box = Hive.box<T>(syncTableName);
    final Map<dynamic, T> map = box.toMap();

    int? desiredKey;
    map.forEach((key, value) {
      if (onPKCheck(value, origin)) {
        desiredKey = key;
      }
    });
    debugPrint('$syncTableName ${desiredKey == null ? 'INSERT' : 'UPDATE(id=$desiredKey)'} $origin');
    desiredKey ??= await box.add(origin);
    // need to reuse id for sync purpose
    (origin as dynamic).id = desiredKey!;
    await box.put(desiredKey, origin);

    return origin;
    // if (desiredKey == null) {
    //   desiredKey = await box.add(origin);
    //   debugPrint('$syncTableName INSERT(id=$desiredKey) new $origin');
    //   // need to reuse id for sync purpose
    //   // origin.id = desiredKey!;
    //   onInsert(origin, desiredKey!);
    //   await box.put(desiredKey, origin);
    //   return origin;
    // }
    // await box.put(desiredKey, origin);
    // debugPrint('$syncTableName UPDATE(id=$desiredKey) $origin');
    // return origin;
  }
}
