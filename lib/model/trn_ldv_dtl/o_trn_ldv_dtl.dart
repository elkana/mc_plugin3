import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import '../../util/hive_util.dart';

part 'o_trn_ldv_dtl.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnLdvDetailOutbound)
class OutboundLdvDetail extends LocalTable<OutboundLdvDetail> {
  // static const syncTableName = 'outbound_trn_ldv_detail';

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
  OutboundLdvDetail({
    this.id,
    this.pk,
    this.lastUpdateBy,
    this.lastUpdateDate,
    this.createdBy,
    this.createdDate,
    this.custName,
    this.alamatTagih,
  }) : super('outbound_trn_ldv_detail');
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

  // static ValueListenable<Box<OTrnLdvDetail>> listenTable() =>
  //     Hive.box<OTrnLdvDetail>(OTrnLdvDetail.syncTableName).listenable();

  // static ValueListenable<Box<OTrnLdvDetail>> listenSomeData(List<dynamic>? keys) =>
  //     Hive.box<OTrnLdvDetail>(OTrnLdvDetail.syncTableName).listenable(keys: keys);

  @override
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

  factory OutboundLdvDetail.fromMap(Map<String, dynamic> map) => OutboundLdvDetail(
        id: map['id']?.toInt(),
        pk: map['pk'] != null ? LdvDetailPk.fromMap(map['pk']) : null,
        lastUpdateBy: map['lastUpdateBy'],
        lastUpdateDate: map['lastUpdateDate'],
        createdBy: map['createdBy'],
        createdDate: map['createdDate'],
        custName: map['custName'],
        alamatTagih: map['alamatTagih'],
      );

  factory OutboundLdvDetail.fromJson(String source) => OutboundLdvDetail.fromMap(json.decode(source));

  // static List<OTrnLdvDetail> findByLdvNo(String ldvNo) {
  //   final list = findAll();
  //   return list.where((e) => e.pk?.ldvNo == ldvNo).toList();
  // }

  // static List<OTrnLdvDetail> findByContractNo(String? contractNo) {
  //   final list = findAll();
  //   return list.where((e) => e.pk?.contractNo == contractNo).toList();
  // }

  // static OTrnLdvDetail? findFirstByContractNo(String? contractNo) {
  //   final list = findAll();
  //   try {
  //     return list.where((e) => e.pk?.contractNo == contractNo).first;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // static bool update(OTrnLdvDetail exist) {
  //   final box = Hive.box<OTrnLdvDetail>(syncTableName);
  //   final map = box.toMap();

  //   dynamic desiredKey;
  //   map.forEach((key, value) {
  //     if (value.pk?.ldvNo == exist.pk?.ldvNo && value.pk?.contractNo == exist.pk?.contractNo) {
  //       desiredKey = key;
  //     }
  //   });

  //   if (desiredKey == null) return false;
  //   box.put(desiredKey, exist);
  //   return true;
  // }

  @override
  String toString() =>
      'OTrnLdvDetail(id: $id, pk: $pk, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate, createdBy: $createdBy, createdDate: $createdDate, custName: $custName, alamatTagih: $alamatTagih)';

  @override
  bool comparePk(a, b) => a.pk?.ldvNo == b.pk?.ldvNo && a.pk?.contractNo == b.pk?.contractNo;

  OutboundLdvDetail? findByPk(String ldvNo, String contractNo) =>
      findAll.firstWhere((element) => element.pk?.ldvNo == ldvNo && element.pk?.contractNo == contractNo);
}

// generated by outbound
@HiveType(typeId: HiveUtil.typeIdTrnLdvDetailPK)
class LdvDetailPk extends LocalTable<LdvDetailPk> {
  // static const syncTableName = 'trn_ldv_detail_pk';

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
  }) : super('trn_ldv_detail_pk');

  @override
  String toString() => 'LdvDetailPk(id: $id, contractNo: $contractNo, ldvNo: $ldvNo)';

  @override
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

  factory LdvDetailPk.fromJson(String source) => LdvDetailPk.fromMap(json.decode(source));

  @override
  bool comparePk(a, b) => a.ldvNo == b.ldvNo && a.contractNo == b.contractNo;
}
