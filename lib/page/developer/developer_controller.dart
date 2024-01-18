import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/abasic_controller.dart';
import '../../model/masters.dart';
import '../../model/mc_photo.dart';
import '../../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../../routes/app_routes.dart';

class DeveloperController extends AViewController {
  var rows = <DataRow>[].obs;

  DataRow tableInfo(String tableName, int rowCount) => DataRow(cells: [
        DataCell(tableName.text.blue900.underline.isIntrinsic
            .make()
            .onInkTap(() => Get.toNamed(Routes.developerTable, arguments: [tableName]))),
        DataCell('$rowCount'.text.isIntrinsic.make()),
      ]);

  @override
  Future refreshData() => processThis(() async {
        rows.clear();
        // rows.add(const DataRow(cells: [
        //   DataCell(Text('Files in Cache')),
        //   DataCell(Text('1000')),
        // ]));
        rows.add(tableInfo(OutboundLdvHeader().syncTableName, OutboundLdvHeader().findAll.length));
        rows.add(tableInfo(InboundLdvHeader().syncTableName, InboundLdvHeader().findAll.length));

        rows.add(tableInfo(OutboundLdvDetail().syncTableName, OutboundLdvDetail().findAll.length));
        rows.add(tableInfo(InboundLdvDetail().syncTableName, InboundLdvDetail().findAll.length));
        rows.add(tableInfo(TrnRVCollComment().syncTableName, TrnRVCollComment().findAll.length));

        rows.add(tableInfo(MstLdvClassification().syncTableName, MstLdvClassification().findAll.length));
        rows.add(tableInfo(MstLdvDelqReason().syncTableName, MstLdvDelqReason().findAll.length));
        rows.add(tableInfo(MstLdvNextAction().syncTableName, MstLdvNextAction().findAll.length));
        rows.add(tableInfo(MstLdvPersonal().syncTableName, MstLdvPersonal().findAll.length));
        rows.add(tableInfo(TrnPhoto().syncTableName, TrnPhoto().findAll.length));
        // rows.add(tableInfo(TblSKTCollateral.syncTableName, TblSKTCollateral.findAll().length));
        // rows.add(tableInfo(TblSKTCollateralRemarks.syncTableName, TblSKTCollateralRemarks.findAll().length));
        // rows.add(tableInfo(TblVehicleInfo.syncTableName, TblVehicleInfo.findAll().length));
        // rows.add(tableInfo(TblSearchLog.syncTableName, TblSearchLog.findAll().length));
        // rows.add(tableInfo(TblSKTSummary.syncTableName, TblSKTSummary.findAll().length));
      });
}
