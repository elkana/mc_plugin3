import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:mc_plugin3/util/commons.dart';

import '../util/hive_util.dart';

part 'mc_trn_rvcollcomment.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnRVCollComment)
class TrnRVCollComment extends LocalTable<TrnRVCollComment> {
  // static const syncTableName = 'trn_rvcoll_comment';

  // reserved by sqlite
  @HiveField(0)
  int? id;
  // reserved by sync system
  @HiveField(1)
  int? lastSyncMillis;
  // reserved by local. forbid to sync
  @HiveField(2)
  bool? modified;
  // @HiveField(3)
  // String? rvCollNo;
  @HiveField(3)
  int? seqNo;
  @HiveField(4)
  RvCollPk? pk;

  // @HiveField(5)
  // String? contractNo;
  @HiveField(5)
  String? ldvNo;
  @HiveField(6)
  String? collId;
  @HiveField(7)
  String? rvbNo;
  @HiveField(8)
  int? instNo;
  @HiveField(9)
  num? receivedAmount;
  @HiveField(10)
  double? penalty;
  @HiveField(11)
  double? collFeeAc;
  @HiveField(12)
  String? lkpFlag;
  @HiveField(13)
  String? delqCode;
  @HiveField(14)
  String? classCode;
  @HiveField(15)
  String? actionPlan;
  @HiveField(16)
  int? potensi;
  @HiveField(17)
  double? planPayAmount;
  @HiveField(18)
  String? mobPhone1;
  @HiveField(19)
  String? whoMet;
  @HiveField(20)
  String? notes;
  @HiveField(21)
  int? promiseDate;
  @HiveField(22)
  String? officeCode;
  // jika ada nomor SPJB (Surat Perjanjian Janji Bayar) krn blm bisa bayar, bikin suratnya biasanya di lokasi
  @HiveField(23)
  String? spjbNo;
  @HiveField(24)
  String? strukNo;
  @HiveField(25)
  int? strukCounter;
  @HiveField(26)
  String? rating;
  @HiveField(27)
  String? periode;
  @HiveField(28)
  double? ambc;
  @HiveField(29)
  String? latitude;
  @HiveField(30)
  String? longitude;
  @HiveField(31)
  String? lastUpdateBy;
  @HiveField(32)
  int? lastUpdateDate;
  @HiveField(33)
  int? createdDate;
  @HiveField(34)
  String? createdBy;
  @HiveField(35)
  int? lkpDate;
  // disediakan jika mau ada splitting
  @HiveField(36)
  double? monthInst;
  @HiveField(37)
  double? deposit;

  @HiveField(38)
  String? cancelledBy;
  @HiveField(39)
  String? cancelledComments;
  @HiveField(40)
  String? cancelledApprove;
  @HiveField(41)
  String? cancelRequest;

  @HiveField(42)
  int? revisitDate;

  TrnRVCollComment({
    this.id,
    this.lastSyncMillis,
    this.modified,
    this.pk,
    this.seqNo,
    this.collId,
    this.ldvNo,
    this.rvbNo,
    this.instNo,
    this.receivedAmount,
    this.penalty,
    this.collFeeAc,
    this.lkpFlag,
    this.delqCode,
    this.classCode,
    this.actionPlan,
    this.potensi,
    this.planPayAmount,
    this.mobPhone1,
    this.whoMet,
    this.notes,
    this.promiseDate,
    this.spjbNo,
    this.strukNo,
    this.strukCounter,
    this.officeCode,
    this.rating,
    this.periode,
    this.ambc,
    this.latitude,
    this.longitude,
    this.lastUpdateBy,
    this.lastUpdateDate,
    this.createdBy,
    this.createdDate,
    this.lkpDate,
    this.monthInst,
    this.deposit,
    this.cancelledBy,
    this.cancelledComments,
    this.cancelledApprove,
    this.cancelRequest,
    this.revisitDate,
  }) : super('trn_rvcoll_comment');

  @override
  bool comparePk(a, b) => a.pk?.rvCollNo == b.pk?.rvCollNo && a.pk?.contractNo == b.pk?.contractNo;

  // factory TrnRVCollComment.fromJson(Map<String, dynamic> data) => _$TrnRVCollCommentFromJson(data);

  // @override
  // Map<String, dynamic> toJson() => _$TrnRVCollCommentToJson(this);

  // static Future cleanAll() async {
  //   debugPrint('cleanup $syncTableName');

  //   final box = Hive.box<TrnRVCollComment>(syncTableName);

  //   await box.clear();
  // }

  // static Future flush(List<TrnRVCollComment>? data) async {
  //   if (data == null) return;

  //   final box = Hive.box<TrnRVCollComment>(syncTableName);

  //   await box.clear();

  //   for (var d in data) {
  //     if (!isNullOrZero(d.lastUpdateDate)) {
  //       d.lastSyncMillis = d.lastUpdateDate;
  //     }
  //     await saveOrUpdate(d);
  //   }

  //   debugPrint('flushed ${box.values.toList().length} $syncTableName');
  // }

  // static TrnRVCollComment? findById(int? key) {
  //   List<TrnRVCollComment> list = findAll();

  //   if (list.isEmpty) return null;

  //   try {
  //     return list.where((e) => e.key == key).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static List<TrnRVCollComment> findAll() {
  //   final box = Hive.box<TrnRVCollComment>(syncTableName);

  //   List<TrnRVCollComment> list = box.values.toList().cast<TrnRVCollComment>();
  //   return list;
  // }

  // static List<TrnRVCollComment> findByLdvNo(String ldvNo) {
  //   final box = Hive.box<TrnRVCollComment>(syncTableName);

  //   List<TrnRVCollComment> list = box.values.toList().cast<TrnRVCollComment>();

  //   return list.where((e) => e.ldvNo == ldvNo).toList();
  // }

  // static List<TrnRVCollComment> findByCollId(String collId) {
  //   List<TrnRVCollComment> list = findAll();

  //   return list.where((e) => e.collId == collId).toList();
  // }

  // static TrnRVCollComment? findByRvCollNoAndContractNo(String rvCollNo, String contractNo) {
  //   List<TrnRVCollComment> list = findAll();

  //   if (list.isEmpty) return null;

  //   try {
  //     return list.where((e) => e.rvCollNo == rvCollNo && e.contractNo == contractNo).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static List<TrnRVCollComment> findByCollIdAndDate(String collId, DateTime date) {
  //   DateTime date1 = changeTime(date, 0, 0, 0);
  //   DateTime date2 = changeTime(date, 23, 59, 59);

  //   List<TrnRVCollComment> list = findAll();

  //   return list
  //       .where((e) =>
  //           e.collId == collId &&
  //           (e.lkpDate! >= date1.millisecondsSinceEpoch && e.lkpDate! <= date2.millisecondsSinceEpoch))
  //       .toList();
  // }

  // static List<TrnRVCollComment> findByDate(DateTime date) {
  //   DateTime date1 = changeTime(date, 0, 0, 0);
  //   DateTime date2 = changeTime(date, 23, 59, 59);

  //   List<TrnRVCollComment> list = findAll();

  //   return list
  //       .where((e) => (e.lkpDate! >= date1.millisecondsSinceEpoch && e.lkpDate! <= date2.millisecondsSinceEpoch))
  //       .toList();
  // }

  // static List<TrnRVCollComment> findByContractNo(String? contractNo) {
  //   List<TrnRVCollComment> list = findAll();

  //   return list.where((e) => e.contractNo == contractNo).toList();
  // }

  // static bool deleteData(TrnRVCollComment exist) {
  //   final box = Hive.box<TrnRVCollComment>(syncTableName);

  //   final Map<dynamic, TrnRVCollComment> map = box.toMap();

  //   dynamic desiredKey;
  //   map.forEach((key, value) {
  //     if (value.rvCollNo == exist.rvCollNo && value.contractNo == exist.contractNo) desiredKey = key;
  //   });

  //   if (desiredKey == null) return false;

  //   box.delete(desiredKey);

  //   return true;
  // }

  // static TrnRVCollComment? findFirstByContractNo(String? contractNo) {
  //   List<TrnRVCollComment> list = findAll();

  //   try {
  //     return list.where((e) => e.contractNo == contractNo).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static Future<TrnRVCollComment> saveOrUpdate(TrnRVCollComment origin) async {
  //   final box = Hive.box<TrnRVCollComment>(syncTableName);

  //   final Map<dynamic, TrnRVCollComment> map = box.toMap();

  //   int? desiredKey;
  //   map.forEach((key, value) {
  //     if (value.rvCollNo == origin.rvCollNo && value.contractNo == origin.contractNo) {
  //       desiredKey = key;
  //     }
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

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastSyncMillis': lastSyncMillis,
      'modified': modified,
      'seqNo': seqNo,
      'pk': pk?.toMap(),
      'ldvNo': ldvNo,
      'collId': collId,
      'rvbNo': rvbNo,
      'instNo': instNo,
      'receivedAmount': receivedAmount,
      'penalty': penalty,
      'collFeeAc': collFeeAc,
      'lkpFlag': lkpFlag,
      'delqCode': delqCode,
      'classCode': classCode,
      'actionPlan': actionPlan,
      'potensi': potensi,
      'planPayAmount': planPayAmount,
      'mobPhone1': mobPhone1,
      'whoMet': whoMet,
      'notes': notes,
      'promiseDate': promiseDate,
      'officeCode': officeCode,
      'spjbNo': spjbNo,
      'strukNo': strukNo,
      'strukCounter': strukCounter,
      'rating': rating,
      'periode': periode,
      'ambc': ambc,
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdateBy': lastUpdateBy,
      'lastUpdateDate': lastUpdateDate,
      'createdDate': createdDate,
      'createdBy': createdBy,
      'lkpDate': lkpDate,
      'monthInst': monthInst,
      'deposit': deposit,
      'cancelledBy': cancelledBy,
      'cancelledComments': cancelledComments,
      'cancelledApprove': cancelledApprove,
      'cancelRequest': cancelRequest,
      'revisitDate': revisitDate,
    };
  }

  factory TrnRVCollComment.fromMap(Map<String, dynamic> map) {
    return TrnRVCollComment(
      id: map['id']?.toInt(),
      lastSyncMillis: map['lastSyncMillis']?.toInt(),
      modified: map['modified'],
      seqNo: map['seqNo']?.toInt(),
      pk: map['pk'] != null ? RvCollPk.fromMap(map['pk']) : null,
      ldvNo: map['ldvNo'],
      collId: map['collId'],
      rvbNo: map['rvbNo'],
      instNo: map['instNo']?.toInt(),
      receivedAmount: map['receivedAmount'],
      penalty: map['penalty']?.toDouble(),
      collFeeAc: map['collFeeAc']?.toDouble(),
      lkpFlag: map['lkpFlag'],
      delqCode: map['delqCode'],
      classCode: map['classCode'],
      actionPlan: map['actionPlan'],
      potensi: map['potensi']?.toInt(),
      planPayAmount: map['planPayAmount']?.toDouble(),
      mobPhone1: map['mobPhone1'],
      whoMet: map['whoMet'],
      notes: map['notes'],
      promiseDate: map['promiseDate']?.toInt(),
      officeCode: map['officeCode'],
      spjbNo: map['spjbNo'],
      strukNo: map['strukNo'],
      strukCounter: map['strukCounter']?.toInt(),
      rating: map['rating'],
      periode: map['periode'],
      ambc: map['ambc']?.toDouble(),
      latitude: map['latitude'],
      longitude: map['longitude'],
      lastUpdateBy: map['lastUpdateBy'],
      lastUpdateDate: map['lastUpdateDate']?.toInt(),
      createdDate: map['createdDate']?.toInt(),
      createdBy: map['createdBy'],
      lkpDate: map['lkpDate']?.toInt(),
      monthInst: map['monthInst']?.toDouble(),
      deposit: map['deposit']?.toDouble(),
      cancelledBy: map['cancelledBy'],
      cancelledComments: map['cancelledComments'],
      cancelledApprove: map['cancelledApprove'],
      cancelRequest: map['cancelRequest'],
      revisitDate: map['revisitDate']?.toInt(),
    );
  }

  factory TrnRVCollComment.fromJson(String source) => TrnRVCollComment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrnRVCollComment(id: $id, lastSyncMillis: $lastSyncMillis, modified: $modified, seqNo: $seqNo, pk: $pk, ldvNo: $ldvNo, collId: $collId, rvbNo: $rvbNo, instNo: $instNo, receivedAmount: $receivedAmount, penalty: $penalty, collFeeAc: $collFeeAc, lkpFlag: $lkpFlag, delqCode: $delqCode, classCode: $classCode, actionPlan: $actionPlan, potensi: $potensi, planPayAmount: $planPayAmount, mobPhone1: $mobPhone1, whoMet: $whoMet, notes: $notes, promiseDate: $promiseDate, officeCode: $officeCode, spjbNo: $spjbNo, strukNo: $strukNo, strukCounter: $strukCounter, rating: $rating, periode: $periode, ambc: $ambc, latitude: $latitude, longitude: $longitude, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate, createdDate: $createdDate, createdBy: $createdBy, lkpDate: $lkpDate, monthInst: $monthInst, deposit: $deposit, cancelledBy: $cancelledBy, cancelledComments: $cancelledComments, cancelledApprove: $cancelledApprove, cancelRequest: $cancelRequest, revisitDate: $revisitDate)';
  }

  TrnRVCollComment? findByContractNo(String? contractNo) =>
      contractNo == null ? null : findAll.firstWhereOrNull((p0) => p0.pk?.contractNo == contractNo);

  @override
  String toJson() => json.encode(toMap());
}

// must be a table, if not hive will error
// Toast => HiveError: Cannot write, unknown type: RvCollPk. Did you forget to register an adapter?
@HiveType(typeId: HiveUtil.typeIdTrnRVCollCommentPK)
class RvCollPk extends LocalTable<RvCollPk> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? rvCollNo;
  @HiveField(2)
  String? contractNo;
  RvCollPk({
    this.id,
    this.rvCollNo,
    this.contractNo,
  }) : super('trn_rvcollcomment_pk');

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rvCollNo': rvCollNo,
      'contractNo': contractNo,
    };
  }

  factory RvCollPk.fromMap(Map<String, dynamic> map) {
    return RvCollPk(
      id: map['id']?.toInt(),
      rvCollNo: map['rvCollNo'],
      contractNo: map['contractNo'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory RvCollPk.fromJson(String source) => RvCollPk.fromMap(json.decode(source));

  @override
  String toString() => 'RvCollPk(id: $id, rvCollNo: $rvCollNo, contractNo: $contractNo)';

  @override
  bool comparePk(a, b) => a.rvCollNo == b.rvCollNo && a.contractNo == b.contractNo;
}
