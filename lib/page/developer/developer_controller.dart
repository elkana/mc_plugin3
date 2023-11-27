import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/abasic_controller.dart';
import '../../model/masters.dart';
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
        DataCell('${rowCount.length}'.text.isIntrinsic.make()),
      ]);

  Future refreshList() => processThis(() async {
        rows.clear();
        // rows.add(const DataRow(cells: [
        //   DataCell(Text('Files in Cache')),
        //   DataCell(Text('1000')),
        // ]));
        rows.add(tableInfo(MstLdvPersonal().syncTableName, MstLdvPersonal().findAll().length));
        // rows.add(tableInfo(TblPhoto.syncTableName, TblPhoto.findAll().length));
        // rows.add(tableInfo(TblSKTCollateral.syncTableName, TblSKTCollateral.findAll().length));
        // rows.add(tableInfo(TblSKTCollateralRemarks.syncTableName, TblSKTCollateralRemarks.findAll().length));
        // rows.add(tableInfo(TblVehicleInfo.syncTableName, TblVehicleInfo.findAll().length));
        // rows.add(tableInfo(TblSearchLog.syncTableName, TblSearchLog.findAll().length));
        // rows.add(tableInfo(TblSKTSummary.syncTableName, TblSKTSummary.findAll().length));
      });
}
