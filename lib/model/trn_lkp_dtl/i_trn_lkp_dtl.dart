import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mc_plugin3/util/hive_util.dart';

import 'o_trn_lkp_dtl.dart';

part 'i_trn_lkp_dtl.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnLdvDetailInbound)
class ITrnLKPDetail extends HiveObject {
  static const syncTableName = 'inbound_trn_ldv_detail';

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
  });

  static ValueListenable<Box<ITrnLKPDetail>> listenTable() =>
      Hive.box<ITrnLKPDetail>(ITrnLKPDetail.syncTableName).listenable();

  static ValueListenable<Box<ITrnLKPDetail>> listenSomeData(List<dynamic>? keys) =>
      Hive.box<ITrnLKPDetail>(ITrnLKPDetail.syncTableName).listenable(keys: keys);

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

  String toJson() => json.encode(toMap());

  factory ITrnLKPDetail.fromJson(String source) => ITrnLKPDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ITrnLKPDetail(id: $id, pk: $pk, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate, createdBy: $createdBy, createdDate: $createdDate, custName: $custName, custNo: $custNo, workStatus: $workStatus, lkpFlag: $lkpFlag, collectionFee: $collectionFee, dueDate: $dueDate, promiseDate: $promiseDate)';
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');
    final box = Hive.box<ITrnLKPDetail>(syncTableName);
    await box.clear();
  }

  static List<ITrnLKPDetail> findAll() {
    final box = Hive.box<ITrnLKPDetail>(syncTableName);
    return box.values.toList().cast<ITrnLKPDetail>();
  }

  static ITrnLKPDetail? findByPK(String? ldvNo, String? contractNo) {
    final list = findAll();
    if (list.isEmpty) return null;
    try {
      return list.where((e) => e.pk?.ldvNo == ldvNo && e.pk?.contractNo == contractNo).first;
    } catch (e) {
      return null;
    }
  }

  static Future<ITrnLKPDetail> saveOrUpdate(ITrnLKPDetail origin) async {
    final box = Hive.box<ITrnLKPDetail>(syncTableName);
    final map = box.toMap();

    int? desiredKey;
    map.forEach((key, value) {
      if (value.pk?.ldvNo == origin.pk?.ldvNo && value.pk?.contractNo == origin.pk?.contractNo) {
        desiredKey = key;
      }
    });
    debugPrint('$syncTableName ${desiredKey == null ? 'INSERT' : 'UPDATE(id=$desiredKey)'} $origin');

    desiredKey ??= await box.add(origin);
    // need to reuse id for sync purpose
    origin.id = desiredKey!;
    await box.put(desiredKey, origin);
    return origin;
  }

  static Future<List<ITrnLKPDetail>> saveOrUpdateAll(List<ITrnLKPDetail>? origin) async {
    if (null == origin) return [];
    var list = origin
        // .map((doc) => ProjectModel.fromMap(doc.data() as Map<String, dynamic>))
        .where((e) => true)
        .toList();
    // log('RECEIVE ${list.length} $syncTableName');
    for (var e in list) {
      await ITrnLKPDetail.saveOrUpdate(e);
    }
    return list;
  }
}
