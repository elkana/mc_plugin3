import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../util/hive_util.dart';

part 'mc_trn_lkp_hdr.g.dart';

// @Table(name = "CM_TRN_LKP_HDRS", schema = "fifocm")

// https://javiercbk.github.io/json_to_dart/
@HiveType(typeId: HiveUtil.typeIdTrnLdvHeader)
class TrnLKPHeader extends LocalTable<TrnLKPHeader> {
  // static const syncTableName = 'trn_ldv_hdr';

  @HiveField(0)
  int? id;
  // reserved by local sync system
  @HiveField(1)
  int? lastSyncMillis;
  // reserved by local. no need to sync
  @HiveField(2)
  bool? modified;
  @HiveField(3)
  String? lkpNo;
  @HiveField(4)
  int? lkpDate;
  @HiveField(5)
  String? officeCode;
  @HiveField(6)
  String? collId;
  @HiveField(7)
  String? workFlag;
  @HiveField(8)
  String? closeBatch;
  @HiveField(9)
  String? lastUpdateBy;
  @HiveField(10)
  String? lastUpdateDate;
  @HiveField(11)
  String? createdDate;
  @HiveField(12)
  String? createdBy;
  @HiveField(13)
  String? closeBatchDate;

  TrnLKPHeader({
    this.id,
    this.lastSyncMillis,
    this.modified,
    this.lkpNo,
    this.lkpDate,
    this.officeCode,
    this.collId,
    this.workFlag,
    this.closeBatch,
    this.lastUpdateBy,
    this.lastUpdateDate,
    this.createdDate,
    this.createdBy,
    this.closeBatchDate,
  }) : super('trn_ldv_hdr');

  // static Future cleanAll() async {
  //   debugPrint('cleanup $syncTableName');
  //   final box = Hive.box<TrnLKPHeader>(syncTableName);
  //   await box.clear();
  // }

  // static Future flush(List<TrnLKPHeader>? data) async {
  //   if (data == null) return;
  //   final box = Hive.box<TrnLKPHeader>(syncTableName);
  //   await box.clear();
  //   for (var d in data) {
  //     // box.add(d);
  //     await saveOrUpdate(d);
  //   }

  //   debugPrint('flushed ${box.values.toList().length} $syncTableName');
  // }

  // static List<TrnLKPHeader> findAll() {
  //   final box = Hive.box<TrnLKPHeader>(syncTableName);
  //   var list = box.values.toList().cast<TrnLKPHeader>();
  //   return list;
  // }

  // static TrnLKPHeader? findLatest() {
  //   var list = findAll();
  //   if (list.isEmpty) return null;
  //   list.sort((a, b) => -a.lkpDate!.compareTo(b.lkpDate!));
  //   try {
  //     return list.first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static TrnLKPHeader? findByLKPNo(String? ldvNo) {
  //   var list = findAll();
  //   if (list.isEmpty) return null;
  //   try {
  //     return list.where((e) => e.lkpNo == ldvNo).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static Future<TrnLKPHeader> saveOrUpdate(TrnLKPHeader origin) async {
  //   final box = Hive.box<TrnLKPHeader>(syncTableName);
  //   final map = box.toMap();

  //   int? desiredKey;
  //   map.forEach((key, value) {
  //     if (value.lkpNo == origin.lkpNo) desiredKey = key;
  //   });

  //   if (desiredKey == null) {
  //     desiredKey = await box.add(origin);
  //     debugPrint('$syncTableName insert new $origin with id = $desiredKey');
  //     // need to reuse id for sync purpose
  //     origin.id = desiredKey!;
  //     await box.put(desiredKey, origin);
  //     return origin;
  //   }

  //   await box.put(desiredKey, origin);
  //   debugPrint('$syncTableName UPDATE $origin with key = $desiredKey');
  //   return origin;
  // }

  // static TrnLKPHeader? findById(int? key) {
  //   var list = findAll();
  //   if (list.isEmpty) return null;
  //   try {
  //     return list.where((e) => e.key == key).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  @override
  String toString() =>
      'TrnLKPHeader(id: $id, lastSyncMillis: $lastSyncMillis, modified: $modified, lkpNo: $lkpNo, lkpDate: $lkpDate, officeCode: $officeCode, collId: $collId, workFlag: $workFlag, closeBatch: $closeBatch, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate, createdDate: $createdDate, createdBy: $createdBy, closeBatchDate: $closeBatchDate)';

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'lastSyncMillis': lastSyncMillis,
        'modified': modified,
        'lkpNo': lkpNo,
        'lkpDate': lkpDate,
        'officeCode': officeCode,
        'collId': collId,
        'workFlag': workFlag,
        'closeBatch': closeBatch,
        'lastUpdateBy': lastUpdateBy,
        'lastUpdateDate': lastUpdateDate,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'closeBatchDate': closeBatchDate,
      };

  factory TrnLKPHeader.fromMap(Map<String, dynamic> map) => TrnLKPHeader(
        id: map['id']?.toInt(),
        lastSyncMillis: map['lastSyncMillis']?.toInt(),
        modified: map['modified'],
        lkpNo: map['lkpNo'],
        lkpDate: map['lkpDate']?.toInt(),
        officeCode: map['officeCode'],
        collId: map['collId'],
        workFlag: map['workFlag'],
        closeBatch: map['closeBatch'],
        lastUpdateBy: map['lastUpdateBy'],
        lastUpdateDate: map['lastUpdateDate']?.toInt(),
        createdDate: map['createdDate']?.toInt(),
        createdBy: map['createdBy'],
        closeBatchDate: map['closeBatchDate']?.toInt(),
      );

  factory TrnLKPHeader.fromJson(String source) => TrnLKPHeader.fromMap(json.decode(source));

  @override
  bool comparePk(a, b) => a.lkpNo == b.lkpNo;
}
