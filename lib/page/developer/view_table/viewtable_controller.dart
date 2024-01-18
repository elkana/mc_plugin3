import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/mc_photo.dart';
import 'package:mc_plugin3/model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import 'package:mc_plugin3/model/trn_ldv_hdr.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/abasic_controller.dart';
import '../../../model/masters.dart';
import '../../../model/mc_trn_rvcollcomment.dart';
import '../../../model/trn_ldv_dtl/i_trn_ldv_dtl.dart';
import '../../../util/commons.dart';

class ViewTableController extends ABasicController {
  List<DataColumn> columns = [];
  List<DataRow> rows = [];
  late String title;

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments[0];
    refreshData(title);
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
      } else if (tableName == OutboundLdvHeader().syncTableName) {
        viewOTrnLdvHeader();
      } else if (tableName == OutboundLdvDetail().syncTableName) {
        viewOTrnLdvDetails();
      } else if (tableName == InboundLdvDetail().syncTableName) {
        viewITrnLdvDetails();
      } else if (tableName == TrnRVCollComment().syncTableName) {
        viewTrnRVCollComment();
      } else if (tableName == TrnPhoto().syncTableName) {
        viewTrnPhoto();
        // } else if (tableName == TblVehicleInfo.syncTableName) {
        //   viewTblVehicleInfo();
        // } else if (tableName == TblSearchLog.syncTableName) {
        //   viewTblSearchLog();
        // } else if (tableName == TblSKTSummary.syncTableName) {
        //   viewTblSKTSummary();
      }
    } finally {
      loading(false);
    }
  }

  void setColumns(List<String> params) => params.forEach((value) => columns.add(DataColumn(label: Text(value))));

  void viewTrnRVCollComment() {
    setColumns(['id', 'rvCollNo', 'contractNo', 'collId', 'whoMet', 'receivedAmount']);
// build rows
    for (var e in TrnRVCollComment().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${e.id}')),
        DataCell(_TextValue('${e.pk?.rvCollNo}')),
        DataCell(_TextValue('${e.pk?.contractNo}')),
        DataCell(_TextValue('${e.collId}')),
        DataCell(_TextValue('${e.whoMet}')),
        DataCell(_TextValue('${e.receivedAmount}')),
      ]));
    }
  }

  void viewOTrnLdvHeader() {
    setColumns(['id', 'ldvNo', 'ldvDate', 'seqNo']);
// build rows
    for (var e in OutboundLdvHeader().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${e.id}')),
        DataCell(_TextValue('${e.ldvNo}')),
        DataCell(_TextValue('${e.ldvDate}')),
        DataCell(_TextValue('${e.collId}')),
      ]));
    }
  }

  void viewOTrnLdvDetails() {
    setColumns(['id', 'ldvNo', 'contractNo', 'custName']);
// build rows
    for (var e in OutboundLdvDetail().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${e.id}')),
        DataCell(_TextValue('${e.pk?.ldvNo}')),
        DataCell(_TextValue('${e.pk?.contractNo}')),
        DataCell(_TextValue('${e.custName}')),
      ]));
    }
  }

  void viewITrnLdvDetails() {
    setColumns(['id', 'ldvNo', 'contractNo', 'custName', 'workStatus']);
// build rows
    for (var e in InboundLdvDetail().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${e.id}')),
        DataCell(_TextValue('${e.pk?.ldvNo}')),
        DataCell(_TextValue('${e.pk?.contractNo}')),
        DataCell(_TextValue('${e.custName}')),
        DataCell(_TextValue('${e.workStatus}')),
      ]));
    }
  }

  void viewMstPersonal() {
    setColumns(['id', 'code', 'description', 'seqNo']);
// build rows
    for (var i in MstLdvPersonal().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.description}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewMstClassification() {
    setColumns(['id', 'code', 'label', 'seqNo']);
// build rows
    for (var i in MstLdvClassification().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.label}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewMstDelqReason() {
    setColumns(['id', 'code', 'description', 'seqNo']);
// build rows
    for (var i in MstLdvDelqReason().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.description}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewMstNextAction() {
    setColumns(['id', 'code', 'label', 'seqNo']);
// build rows
    for (var i in MstLdvNextAction().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.code}')),
        DataCell(_TextValue('${i.label}')),
        DataCell(_TextValue('${i.seqNo}')),
      ]));
    }
  }

  void viewTrnPhoto() {
    setColumns(
        ['id', 'createdDate', 'sourceId', 'photoId', 'blobPath', 'fileName', 'label', 'mimeType', 'latlong', 'userId']);
// build rows
    for (var i in TrnPhoto().findAll) {
      rows.add(DataRow(cells: [
        DataCell(_TextValue('${i.id}')),
        DataCell(_TextValue('${i.createdDate}')),
        DataCell(_TextValue('${i.sourceId}')),
        DataCell(_TextValue('${i.photoId}')),
        DataCell(_TextValue('${i.blobPath}')),
        DataCell(_TextValue('${i.fileName}')),
        DataCell(_TextValue('${i.label}')),
        DataCell(_TextValue('${i.mimeType}')),
        DataCell(_TextValue('${i.latitude},${i.longitude}')),
        DataCell(_TextValue('${i.userId}')),
      ]));
    }
  }

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
}

class _TextValue extends StatelessWidget {
  final String text;
  const _TextValue(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(context) => text.text.xs.isIntrinsic.make();
}
