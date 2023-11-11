import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../model/user.dart';

class HiveUtil {
  static const typeIdUserModel = 0;
  // static const typeIdContractDetail = 1;
  static const typeIdPhoto = 5;
  static const typeIdSearchLog = 6;
  static const typeIdSktHeader = 10;
  static const typeIdSktAsset = 11;
  static const typeIdSktCollateral = 12;
  static const typeIdSktInstallment = 13;
  static const typeIdSktCollateralRemarks = 14;
  static const typeIdSktSummary = 19;
  static const typeIdVehicleInfo = 20;

  static Future registerAdaptersFirstTime() async {
    if (!kIsWeb) {
      WidgetsFlutterBinding.ensureInitialized();
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    Hive.registerAdapter(UserModelAdapter());
    // Hive.registerAdapter(TblSKTSummaryAdapter());
    // Hive.registerAdapter(TblSKTHeaderAdapter());
    // Hive.registerAdapter(TblSKTAssetAdapter());
    // Hive.registerAdapter(TblSKTCollateralAdapter());
    // Hive.registerAdapter(TblSKTCollateralRemarksAdapter());
    // Hive.registerAdapter(TblSKTInstallmentAdapter());
    // Hive.registerAdapter(TblPhotoAdapter());
    // Hive.registerAdapter(TblVehicleInfoAdapter());
    // Hive.registerAdapter(TblSearchLogAdapter());

    await Hive.openBox<UserModel>(UserModel.syncTableName);
    // await Hive.openBox<TblSKTSummary>(TblSKTSummary.syncTableName);
    // await Hive.openBox<TblSKTHeader>(TblSKTHeader.syncTableName);
    // await Hive.openBox<TblSKTAsset>(TblSKTAsset.syncTableName);
    // await Hive.openBox<TblSKTCollateral>(TblSKTCollateral.syncTableName);
    // await Hive.openBox<TblSKTCollateralRemarks>(TblSKTCollateralRemarks.syncTableName);
    // await Hive.openBox<TblSKTInstallment>(TblSKTInstallment.syncTableName);
    // await Hive.openBox<TblPhoto>(TblPhoto.syncTableName);
    // await Hive.openBox<TblVehicleInfo>(TblVehicleInfo.syncTableName);
    // await Hive.openBox<TblSearchLog>(TblSearchLog.syncTableName);
  }

  static Future cleanAll(bool cleanMaster) async {
    if (cleanMaster) await cleanMastersOnly();

    await Future.wait([
      // MstTaskType.cleanAll(),
      // MstOffice.cleanAll(),
      UserModel.cleanAll(),

      cleanMastersOnly(),
      cleanTransactionsOnly(),
      //add more here
    ]);
  }

  static Future cleanMastersOnly() async {
    await Future.wait([
      // MstMobileSetup.cleanAll(),
      // MstLdvClassification.cleanAll(),
    ]);
  }

  static Future cleanTransactionsOnly() => Future.wait([
        // TblSKTSummary.cleanAll(),
        // TblSKTHeader.cleanAll(),
        // TblSKTAsset.cleanAll(),
        // TblSKTCollateral.cleanAll(),
        // TblSKTCollateralRemarks.cleanAll(),
        // TblSKTInstallment.cleanAll(),
        // TblPhoto.cleanAll(),
        // TblVehicleInfo.cleanAll(),
        // TblSearchLog.cleanAll(),
        //add more here
      ]);
}
