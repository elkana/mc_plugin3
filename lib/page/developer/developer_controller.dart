import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';
import 'package:mc_plugin3/model/trn_lkp_dtl/o_trn_lkp_dtl.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/abasic_controller.dart';
import '../../model/masters.dart';
import '../../model/trn_lkp_dtl/i_trn_lkp_dtl.dart';
import '../../routes/app_routes.dart';

class DeveloperController extends ABasicController {
  var rows = <DataRow>[].obs;

  @override
  void onReady() {
    super.onReady();
    refreshList();
  }

  DataRow tableInfo(String tableName, int rowCount) => DataRow(cells: [
        DataCell(tableName.text.blue900.underline.isIntrinsic
            .make()
            .onInkTap(() => Get.toNamed(Routes.developerTable, arguments: [tableName]))),
        DataCell('$rowCount'.text.isIntrinsic.make()),
      ]);

  Future refreshList() => processThis(() async {
        rows.clear();
        // rows.add(const DataRow(cells: [
        //   DataCell(Text('Files in Cache')),
        //   DataCell(Text('1000')),
        // ]));
        rows.add(tableInfo(OTrnLdvHeader().syncTableName, OTrnLdvHeader().findAll().length));
        rows.add(tableInfo(ITrnLdvHeader().syncTableName, ITrnLdvHeader().findAll().length));

        rows.add(tableInfo(OTrnLKPDetail().syncTableName, OTrnLKPDetail().findAll().length));
        rows.add(tableInfo(ITrnLKPDetail().syncTableName, ITrnLKPDetail().findAll().length));

        rows.add(tableInfo(MstLdvClassification().syncTableName, MstLdvClassification().findAll().length));
        rows.add(tableInfo(MstLdvDelqReason().syncTableName, MstLdvDelqReason().findAll().length));
        rows.add(tableInfo(MstLdvNextAction().syncTableName, MstLdvNextAction().findAll().length));
        // rows.add(tableInfo(TblPhoto.syncTableName, TblPhoto.findAll().length));
        // rows.add(tableInfo(TblSKTCollateral.syncTableName, TblSKTCollateral.findAll().length));
        // rows.add(tableInfo(TblSKTCollateralRemarks.syncTableName, TblSKTCollateralRemarks.findAll().length));
        // rows.add(tableInfo(TblVehicleInfo.syncTableName, TblVehicleInfo.findAll().length));
        // rows.add(tableInfo(TblSearchLog.syncTableName, TblSearchLog.findAll().length));
        // rows.add(tableInfo(TblSKTSummary.syncTableName, TblSKTSummary.findAll().length));
      });
}
