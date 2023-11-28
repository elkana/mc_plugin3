import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/abasic_controller.dart';
import '../../../model/masters.dart';
import '../../../util/commons.dart';

class ViewTableController extends ABasicController {
  List<DataColumn> columns = [];
  List<DataRow> rows = [];

  @override
  void onInit() {
    super.onInit();
    refreshData(Get.arguments[0]);
  }

  Future refreshData(dynamic tableName) async {
    loading(true);
    try {
      rows.clear();
      columns.clear();
      log('query $tableName');
      if (tableName == MstLdvPersonal().syncTableName) {
        viewMstPersonal();
      } else if (tableName == MstLdvClassification().syncTableName) {
        viewMstClassification();
      } else if (tableName == MstLdvDelqReason().syncTableName) {
        viewMstDelqReason();
      } else if (tableName == MstLdvNextAction().syncTableName) {
        viewMstNextAction();
      }
      // else if (tableName == TblSKTHeader.syncTableName) {
      //   viewTblSKTHeader();
      // } else if (tableName == TblSKTCollateral.syncTableName) {
      //   viewTblSKTCollateral();
      // } else if (tableName == TblSKTCollateralRemarks.syncTableName) {
      //   viewTblSKTCollateralRemarks();
      // } else if (tableName == TblVehicleInfo.syncTableName) {
      //   viewTblVehicleInfo();
      // } else if (tableName == TblSearchLog.syncTableName) {
      //   viewTblSearchLog();
      // } else if (tableName == TblSKTSummary.syncTableName) {
      //   viewTblSKTSummary();
      // }
    } finally {
      loading(false);
    }
  }

  void viewMstPersonal() {
    // build columns
    columns.add(const DataColumn(label: Text('id')));
    columns.add(const DataColumn(label: Text('code')));
    columns.add(const DataColumn(label: Text('description')));
    columns.add(const DataColumn(label: Text('seqNo')));

// build rows
    for (var i in MstLdvPersonal().findAll()) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.description}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewMstClassification() {
    // build columns
    columns.add(const DataColumn(label: Text('id')));
    columns.add(const DataColumn(label: Text('code')));
    columns.add(const DataColumn(label: Text('description')));
    columns.add(const DataColumn(label: Text('seqNo')));

// build rows
    for (var i in MstLdvClassification().findAll()) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.label}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewMstDelqReason() {
    // build columns
    columns.add(const DataColumn(label: Text('id')));
    columns.add(const DataColumn(label: Text('code')));
    columns.add(const DataColumn(label: Text('description')));
    columns.add(const DataColumn(label: Text('seqNo')));

// build rows
    for (var i in MstLdvDelqReason().findAll()) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.description}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewMstNextAction() {
    // build columns
    columns.add(const DataColumn(label: Text('id')));
    columns.add(const DataColumn(label: Text('code')));
    columns.add(const DataColumn(label: Text('description')));
    columns.add(const DataColumn(label: Text('seqNo')));

// build rows
    for (var i in MstLdvNextAction().findAll()) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.label}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

//   void viewTblSKTCollateral() {
//     // build columns
//     columns.add(const DataColumn(label: Text('collateralNo')));
//     columns.add(const DataColumn(label: Text('collateralName')));
//     columns.add(const DataColumn(label: Text('sktNo')));
//     columns.add(const DataColumn(label: Text('bastkNo')));
//     columns.add(const DataColumn(label: Text('createdDate')));
//     columns.add(const DataColumn(label: Text('remarks')));
//     columns.add(const DataColumn(label: Text('plateNo')));
//     columns.add(const DataColumn(label: Text('repoStatus')));

// // build rows
//     for (var i in TblSKTCollateral.findAll()) {
//       rows.add(DataRow(cells: [
//         DataCell(_TextValue('${i.collateralNo}')),
//         DataCell(_TextValue('${i.collateralName}')),
//         DataCell(_TextValue('${i.sktNo}')),
//         DataCell(_TextValue('${i.bastkNo}')),
//         DataCell(_TextValue('${i.createdDate}')),
//         DataCell(_TextValue('${i.remarks}')),
//         DataCell(_TextValue('${i.plateNo}')),
//         DataCell(_TextValue('${i.repoStatus}')),
//       ]));
//     }
//   }

//   void viewTblSKTCollateralRemarks() {
//     var lColumns = [
//       'photoId',
//       'remarks',
//       'userId',
//       'submitDate',
//       'collateralNo',
//       'sktNo',
//       'uid',
//     ];
// // build columns
//     for (var c in lColumns) {
//       columns.add(DataColumn(label: Text(c)));
//     }
// // build rows
//     for (var i in TblSKTCollateralRemarks.findAll()) {
//       rows.add(DataRow(cells: [
//         DataCell(_TextValue('${i.photoId}')),
//         DataCell(_TextValue('${i.remarks}')),
//         DataCell(_TextValue('${i.userId}')),
//         DataCell(_TextValue('${i.submitDate}')),
//         DataCell(_TextValue('${i.collateralNo}')),
//         DataCell(_TextValue('${i.sktNo}')),
//         DataCell(_TextValue('${i.uid}')),
//       ]));
//     }
//   }

//   void viewTrnPhoto() {
//     // build columns
//     columns.add(const DataColumn(label: Text('id')));
//     columns.add(const DataColumn(label: Text('createdDate')));
//     columns.add(const DataColumn(label: Text('sourceId')));
//     columns.add(const DataColumn(label: Text('photoId')));
//     columns.add(const DataColumn(label: Text('blobPath')));
//     columns.add(const DataColumn(label: Text('fileName')));
//     columns.add(const DataColumn(label: Text('label')));
//     columns.add(const DataColumn(label: Text('mimeType')));
//     columns.add(const DataColumn(label: Text('latitude')));
//     columns.add(const DataColumn(label: Text('longitude')));
//     columns.add(const DataColumn(label: Text('userId')));

// // build rows
//     for (var i in TblPhoto.findAll()) {
//       rows.add(DataRow(cells: [
//         DataCell(_TextValue('${i.id}')),
//         DataCell(_TextValue('${i.createdDate}')),
//         DataCell(_TextValue(i.sourceId)),
//         DataCell(_TextValue(i.photoId)),
//         DataCell(_TextValue('${i.blobPath}')),
//         DataCell(_TextValue(i.fileName)),
//         DataCell(_TextValue('${i.label}')),
//         DataCell(_TextValue('${i.mimeType}')),
//         DataCell(_TextValue('${i.latitude}')),
//         DataCell(_TextValue('${i.longitude}')),
//         DataCell(_TextValue('${i.userId}')),
//       ]));
//     }
//   }

//   void viewTblVehicleInfo() {
//     // build columns
//     columns.add(const DataColumn(label: Text('contractNo')));
//     columns.add(const DataColumn(label: Text('platNo')));
//     columns.add(const DataColumn(label: Text('debiturName')));
//     columns.add(const DataColumn(label: Text('chassisNo')));
//     columns.add(const DataColumn(label: Text('engineNo')));

// // build rows
//     for (var i in TblVehicleInfo.findAll()) {
//       rows.add(DataRow(cells: [
//         DataCell(_TextValue('${i.contractNo}')),
//         DataCell(_TextValue('${i.platNo}')),
//         DataCell(_TextValue('${i.debiturName}')),
//         DataCell(_TextValue('${i.chassisNo}')),
//         DataCell(_TextValue('${i.engineNo}')),
//       ]));
//     }
//   }

//   void viewTblSearchLog() {
//     // build columns
//     columns.add(const DataColumn(label: Text('userId')));
//     columns.add(const DataColumn(label: Text('searchQuery')));
//     columns.add(const DataColumn(label: Text('category')));
//     columns.add(const DataColumn(label: Text('searchTimestamp')));

// // build rows
//     for (var i in TblSearchLog.findAll()) {
//       rows.add(DataRow(cells: [
//         DataCell(_TextValue('${i.userId}')),
//         DataCell(_TextValue('${i.searchQuery}')),
//         DataCell(_TextValue('${i.category}')),
//         DataCell(_TextValue('${i.searchTimestamp}')),
//       ]));
//     }
//   }

//   void viewTblSKTSummary() {
//     // build columns
//     columns.add(const DataColumn(label: Text('monthName')));
//     columns.add(const DataColumn(label: Text('totalSkt')));

// // build rows
//     for (var i in TblSKTSummary.findAll()) {
//       rows.add(DataRow(cells: [
//         DataCell(_TextValue('${i.monthName}')),
//         DataCell(_TextValue('${i.totalSkt}')),
//       ]));
//     }
//   }
}

class _TextValue extends StatelessWidget {
  final String text;
  const _TextValue(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => text.text.xs.isIntrinsic.make();
}
