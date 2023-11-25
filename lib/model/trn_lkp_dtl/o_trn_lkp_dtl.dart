import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../util/hive_util.dart';

part 'o_trn_lkp_dtl.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnLdvDetailOutbound)
class OTrnLKPDetail extends HiveObject {
  static const syncTableName = 'outbound_trn_ldv_detail';

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
  String? alamatTagih;
  OTrnLKPDetail({
    this.id,
    this.pk,
    this.lastUpdateBy,
    this.lastUpdateDate,
    this.createdBy,
    this.createdDate,
    this.custName,
    this.alamatTagih,
  });
  // @HiveField(5)
  // int? collectionFee;
  // @HiveField(5)
  // DateTime? dueDate;
  // @HiveField(5)
  // String? facilityCode;
  // @HiveField(5)
  // String? facilityDescr;
  // @HiveField(5)
  // String? fixPhone;
  // @HiveField(5)
  // String? fixPhoneArea;
  // @HiveField(5)
  // String? instNo;
  // @HiveField(5)
  // int? installment;
  // @HiveField(5)
  // int? interestAmbc;
  // @HiveField(5)
  // int? interestAmountCollected;
  // @HiveField(5)
  // String? isLkh;
  // @HiveField(5)
  // int? jmlKunjungan;
  // @HiveField(5)
  // String? kecamatan;
  // @HiveField(5)
  // String? kelurahan;
  // @HiveField(5)
  // String? kodePos;
  // @HiveField(5)
  // String? latitude;
  // @HiveField(5)
  // String? longitude;
  // @HiveField(5)
  // String? mobPhone1;
  // @HiveField(5)
  // String? mobPhone2;
  // @HiveField(5)
  // String? occupation;
  // @HiveField(5)
  // int? ovd;
  // @HiveField(5)
  // DateTime? ovdDueDate;
  // @HiveField(5)
  // int? ovdInstNo;
  // @HiveField(5)
  // int? paidAmount;
  // @HiveField(5)
  // int? penaltyAmbc;
  // @HiveField(5)
  // int? penaltyAmountCollected;
  // @HiveField(5)
  // int? principalAmbc;
  // @HiveField(5)
  // int? principalAmountCollected;
  // @HiveField(5)
  // int? principalOutstanding;
  // @HiveField(5)
  // int? priority;
  // @HiveField(5)
  // DateTime? promiseDate;
  // @HiveField(5)
  // String? rt;
  // @HiveField(5)
  // String? rw;
  // @HiveField(5)
  // String? subFacilityCode;
  // @HiveField(5)
  // String? subFacilityDescr;
  // @HiveField(5)
  // String? subOccupation;
  // @HiveField(5)
  // int? tenor;
  // @HiveField(5)
  // String? tetapDitagih;
  // @HiveField(5)
  // int? tglJatuhTempo;
  // @HiveField(5)
  // String? trenBucket;
  // @HiveField(5)
  // String? trenPolaBayar;
  // @HiveField(5)
  // String? trenTglBayar;
  // @HiveField(5)
  // String? unitMobil;
  // @HiveField(5)
  // String? workStatus;

  static ValueListenable<Box<OTrnLKPDetail>> listenTable() =>
      Hive.box<OTrnLKPDetail>(OTrnLKPDetail.syncTableName).listenable();

  static ValueListenable<Box<OTrnLKPDetail>> listenSomeData(List<dynamic>? keys) =>
      Hive.box<OTrnLKPDetail>(OTrnLKPDetail.syncTableName).listenable(keys: keys);

  Map<String, dynamic> toMap() => {
        'id': id,
        'pk': pk?.toMap(),
        'lastUpdateBy': lastUpdateBy,
        'lastUpdateDate': lastUpdateDate,
        'createdBy': createdBy,
        'createdDate': createdDate,
        'custName': custName,
        'alamatTagih': alamatTagih,
      };

  factory OTrnLKPDetail.fromMap(Map<String, dynamic> map) => OTrnLKPDetail(
        id: map['id']?.toInt(),
        pk: map['pk'] != null ? LdvDetailPk.fromMap(map['pk']) : null,
        lastUpdateBy: map['lastUpdateBy'],
        lastUpdateDate: map['lastUpdateDate'],
        createdBy: map['createdBy'],
        createdDate: map['createdDate'],
        custName: map['custName'],
        alamatTagih: map['alamatTagih'],
      );

  String toJson() => json.encode(toMap());

  factory OTrnLKPDetail.fromJson(String source) => OTrnLKPDetail.fromMap(json.decode(source));

  static Future flush(List<OTrnLKPDetail>? data) async {
    if (data == null) return;

    final box = Hive.box<OTrnLKPDetail>(syncTableName);

    await box.clear();

    for (var d in data) {
      // box.add(d);
      await saveOrUpdate(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');
    final box = Hive.box<OTrnLKPDetail>(syncTableName);
    await box.clear();
  }

  static OTrnLKPDetail? findById(int? key) {
    final list = findAll();

    if (list.isEmpty) return null;

    try {
      return list.where((e) => e.key == key).first;
    } catch (e) {
      return null;
    }
  }

  static bool isEmpty() {
    final box = Hive.box<OTrnLKPDetail>(syncTableName);
    return box.isEmpty;
  }

  static List<OTrnLKPDetail> findAll() {
    final box = Hive.box<OTrnLKPDetail>(syncTableName);
    return box.values.toList().cast<OTrnLKPDetail>();
  }

  static List<OTrnLKPDetail> findByLdvNo(String ldvNo) {
    final list = findAll();
    return list.where((e) => e.pk?.ldvNo == ldvNo).toList();
  }

  static OTrnLKPDetail? findByPK(String? ldvNo, String? contractNo) {
    final list = findAll();
    if (list.isEmpty) return null;
    try {
      return list.where((e) => e.pk?.ldvNo == ldvNo && e.pk?.contractNo == contractNo).first;
    } catch (e) {
      return null;
    }
  }

  static List<OTrnLKPDetail> findByContractNo(String? contractNo) {
    final list = findAll();
    return list.where((e) => e.pk?.contractNo == contractNo).toList();
  }

  static OTrnLKPDetail? findFirstByContractNo(String? contractNo) {
    final list = findAll();
    try {
      return list.where((e) => e.pk?.contractNo == contractNo).first;
    } catch (e) {
      return null;
    }
  }

  static bool update(OTrnLKPDetail exist) {
    final box = Hive.box<OTrnLKPDetail>(syncTableName);
    final map = box.toMap();

    dynamic desiredKey;
    map.forEach((key, value) {
      if (value.pk?.ldvNo == exist.pk?.ldvNo && value.pk?.contractNo == exist.pk?.contractNo) {
        desiredKey = key;
      }
    });

    if (desiredKey == null) return false;
    box.put(desiredKey, exist);
    return true;
  }

  // static change(String s, String t) {
  //   final box = Hive.box<TrnLKPDetail>(syncTableName);

  //   List<TrnLKPDetail> all = findAll();

  //   for (var f in all) {
  //     if (f.contractNo == s) {
  //       f.contractNo = t;
  //       box.put(f.key, f);
  //       return;
  //     }
  //   }
  // }

  static Future<OTrnLKPDetail> saveOrUpdate(OTrnLKPDetail origin) async {
    final box = Hive.box<OTrnLKPDetail>(syncTableName);
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
    LdvDetailPk.saveOrUpdate(origin.pk!);

    return origin;
  }

//   static Future<OTrnLKPDetail> saveOrUpdateDeprecated(OTrnLKPDetail origin) async {
//     final box = Hive.box<OTrnLKPDetail>(syncTableName);
//     final map = box.toMap();

//     int? desiredKey;
//     map.forEach((key, value) {
//       if (value.pk?.ldvNo == origin.pk?.ldvNo && value.pk?.contractNo == origin.pk?.contractNo) {
//         desiredKey = key;
//       }
//     });

// // TODO check utk field lkpflag knp msh NEW
//     if (desiredKey == null) {
//       desiredKey = await box.add(origin);

//       debugPrint('$syncTableName insert new $origin with id = $desiredKey');

//       // need to reuse id for sync purpose
//       origin.id = desiredKey!;
//       await box.put(desiredKey, origin);

//       return origin;
//     }

//     await box.put(desiredKey, origin);
//     debugPrint('$syncTableName UPDATE $origin with key = $desiredKey');

//     return origin;
//   }

  static Future<List<OTrnLKPDetail>> saveOrUpdateAll(List<OTrnLKPDetail>? origin) async {
    if (null == origin) return [];
    var list = origin
        // .map((doc) => ProjectModel.fromMap(doc.data() as Map<String, dynamic>))
        .where((e) => true)
        .toList();
    // log('RECEIVE ${list.length} $syncTableName');
    for (var e in list) {
      await OTrnLKPDetail.saveOrUpdate(e);
    }
    return list;
  }

  @override
  String toString() =>
      'OTrnLKPDetail(id: $id, pk: $pk, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate, createdBy: $createdBy, createdDate: $createdDate, custName: $custName, alamatTagih: $alamatTagih)';
}

// generated by outbound
@HiveType(typeId: HiveUtil.typeIdTrnLdvDetailPK)
class LdvDetailPk extends HiveObject {
  static const syncTableName = 'trn_ldv_detail_pk';

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? contractNo;
  @HiveField(2)
  String? ldvNo;

  LdvDetailPk({
    this.id,
    this.contractNo,
    this.ldvNo,
  });

  @override
  String toString() => 'LdvDetailPk(id: $id, contractNo: $contractNo, ldvNo: $ldvNo)';

  Map<String, dynamic> toMap() => {
        'id': id,
        'contractNo': contractNo,
        'ldvNo': ldvNo,
      };

  factory LdvDetailPk.fromMap(Map<String, dynamic> map) => LdvDetailPk(
        id: map['id']?.toInt(),
        contractNo: map['contractNo'],
        ldvNo: map['ldvNo'],
      );

  String toJson() => json.encode(toMap());

  factory LdvDetailPk.fromJson(String source) => LdvDetailPk.fromMap(json.decode(source));

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');
    final box = Hive.box<LdvDetailPk>(syncTableName);
    await box.clear();
  }

  static List<LdvDetailPk> findAll() {
    final box = Hive.box<LdvDetailPk>(syncTableName);
    return box.values.toList().cast<LdvDetailPk>();
  }

  static Future<LdvDetailPk> saveOrUpdate(LdvDetailPk origin) async {
    final box = Hive.box<LdvDetailPk>(syncTableName);
    final map = box.toMap();

    int? desiredKey;
    map.forEach((key, value) {
      if (value.ldvNo == origin.ldvNo && value.contractNo == origin.contractNo) {
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
}
