import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mc_plugin3/util/commons.dart';

import 'package:mc_plugin3/util/hive_util.dart';

import 'o_trn_lkp_dtl.dart';

part 'i_trn_lkp_dtl.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnLdvDetailInbound)
class ITrnLKPDetail extends LocalTable<ITrnLKPDetail> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  LdvDetailPk? pk;
  @HiveField(2)
  String? lastUpdateBy;
  @HiveField(3)
  String? lastUpdateDate;
  @HiveField(4)
  String? createdBy;
  @HiveField(5)
  String? createdDate;
  @HiveField(6)
  String? custName;
  @HiveField(7)
  String? custNo;
  @HiveField(8)
  String? workStatus;
  @HiveField(9)
  String? lkpFlag;
  @HiveField(10)
  int? collectionFee;
  @HiveField(11)
  DateTime? dueDate;
  @HiveField(12)
  DateTime? promiseDate;

  ITrnLKPDetail({
    this.id,
    this.pk,
    this.lastUpdateBy,
    this.lastUpdateDate,
    this.createdBy,
    this.createdDate,
    this.custName,
    this.custNo,
    this.workStatus,
    this.lkpFlag,
    this.collectionFee,
    this.dueDate,
    this.promiseDate,
  }) : super('inbound_trn_ldv_detail');
  // @HiveField(13)
  // int? instNo;
  // @HiveField(14)
  // int? interestAmbc;
  // @HiveField(15)
  // int? interestAmountCollected;
  // @HiveField(15)
  // DateTime? ovdDueDate;
  // @HiveField(16)
  // int? ovdInstNo;
  // @HiveField(17)
  // String? paymentCancelledBy;
  // @HiveField(18)
  // int? penaltyAmbc;
  // @HiveField(19)
  // int? penaltyAmountCollected;
  // @HiveField(20)
  // int? principalAmbc;
  // @HiveField(21)
  // int? principalAmountCollected;
  // @HiveField(22)
  // int? principalOutstanding;
  // @HiveField(23)
  // int? priority;
  // @HiveField(10)
  // String? docStatus;
  // @HiveField(25)
  // DateTime? sktEffectiveDate;
  // @HiveField(26)
  // String? sktResultIfFailed;
  // @HiveField(27)
  // int? totalVisit;
  // @HiveField(28)
  // String? trenBucket;
  // @HiveField(29)
  // String? trenPolaBayar;
  // @HiveField(30)
  // String? trenTglBayar;

  // static ValueListenable<Box<ITrnLKPDetail>> listenTable() => Hive.box<ITrnLKPDetail>(syncTableName).listenable();

  // static ValueListenable<Box<ITrnLKPDetail>> listenSomeData(List<dynamic>? keys) =>
  //     Hive.box<ITrnLKPDetail>(syncTableName).listenable(keys: keys);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pk': pk?.toMap(),
      'lastUpdateBy': lastUpdateBy,
      'lastUpdateDate': lastUpdateDate,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'custName': custName,
      'custNo': custNo,
      'workStatus': workStatus,
      'lkpFlag': lkpFlag,
      'collectionFee': collectionFee,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'promiseDate': promiseDate?.millisecondsSinceEpoch,
    };
  }

  factory ITrnLKPDetail.fromMap(Map<String, dynamic> map) {
    return ITrnLKPDetail(
      id: map['id']?.toInt(),
      pk: map['pk'] != null ? LdvDetailPk.fromMap(map['pk']) : null,
      lastUpdateBy: map['lastUpdateBy'],
      lastUpdateDate: map['lastUpdateDate'],
      createdBy: map['createdBy'],
      createdDate: map['createdDate'],
      custName: map['custName'],
      custNo: map['custNo'],
      workStatus: map['workStatus'],
      lkpFlag: map['lkpFlag'],
      collectionFee: map['collectionFee']?.toInt(),
      dueDate: map['dueDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dueDate']) : null,
      promiseDate: map['promiseDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['promiseDate']) : null,
    );
  }

  factory ITrnLKPDetail.fromJson(String source) => ITrnLKPDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ITrnLKPDetail(id: $id, pk: $pk, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate, createdBy: $createdBy, createdDate: $createdDate, custName: $custName, custNo: $custNo, workStatus: $workStatus, lkpFlag: $lkpFlag, collectionFee: $collectionFee, dueDate: $dueDate, promiseDate: $promiseDate)';
  }

  @override
  bool comparePk(a, b) => a.pk?.ldvNo == b.pk?.ldvNo && a.pk?.contractNo == b.pk?.contractNo;

  ITrnLKPDetail? findByPk(String ldvNo, String contractNo) =>
      findAll().firstWhereOrNull((element) => element.pk?.ldvNo == ldvNo && element.pk?.contractNo == contractNo);
}
