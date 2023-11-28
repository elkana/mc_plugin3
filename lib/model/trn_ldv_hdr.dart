import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:mc_plugin3/util/hive_util.dart';
part 'trn_ldv_hdr.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnLdvHeaderOutbound)
class OTrnLdvHeader extends LocalTable<OTrnLdvHeader> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? ldvNo;
  @HiveField(2)
  String? ldvDate;
  @HiveField(3)
  String? collId;
  @HiveField(4)
  String? collName;
  @HiveField(5)
  String? officeCode;
  @HiveField(6)
  String? officeName;

  OTrnLdvHeader({
    this.id,
    this.ldvNo,
    this.ldvDate,
    this.collId,
    this.collName,
    this.officeCode,
    this.officeName,
  }) : super('outbound_trn_ldv_header');

  @override
  bool comparePk(a, b) => a.ldvNo == b.ldvNo;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'ldvNo': ldvNo,
        'ldvDate': ldvDate,
        'collId': collId,
        'collName': collName,
        'officeCode': officeCode,
        'officeName': officeName,
      };

  factory OTrnLdvHeader.fromMap(Map<String, dynamic> map) => OTrnLdvHeader(
        id: map['id']?.toInt(),
        ldvNo: map['ldvNo'],
        ldvDate: map['ldvDate'],
        collId: map['collId'],
        collName: map['collName'],
        officeCode: map['officeCode'],
        officeName: map['officeName'],
      );

  factory OTrnLdvHeader.fromJson(String source) => OTrnLdvHeader.fromMap(json.decode(source));

  @override
  String toString() =>
      'OTrnLdvHeader(id: $id, ldvNo: $ldvNo, ldvDate: $ldvDate, collId: $collId, collName: $collName, officeCode: $officeCode, officeName: $officeName)';

  OTrnLdvHeader? findByPk(String ldvNo) => findAll().firstWhere((element) => element.ldvNo == ldvNo);
}

@HiveType(typeId: HiveUtil.typeIdTrnLdvHeaderInbound)
class ITrnLdvHeader extends LocalTable<ITrnLdvHeader> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? ldvNo;
  @HiveField(2)
  String? ldvDate;
  @HiveField(3)
  String? closeBatch;
  @HiveField(4)
  String? closeBatchDate;
  @HiveField(5)
  String? collId;
  @HiveField(6)
  String? collName;
  @HiveField(7)
  String? officeCode;
  @HiveField(8)
  String? officeName;

  ITrnLdvHeader({
    this.id,
    this.ldvNo,
    this.ldvDate,
    this.closeBatch,
    this.closeBatchDate,
    this.collId,
    this.collName,
    this.officeCode,
    this.officeName,
  }) : super('inbound_trn_ldv_header');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'ldvNo': ldvNo,
        'ldvDate': ldvDate,
        'closeBatch': closeBatch,
        'closeBatchDate': closeBatchDate,
        'collId': collId,
        'collName': collName,
        'officeCode': officeCode,
        'officeName': officeName,
      };

  factory ITrnLdvHeader.fromMap(Map<String, dynamic> map) => ITrnLdvHeader(
        id: map['id']?.toInt(),
        ldvNo: map['ldvNo'],
        ldvDate: map['ldvDate'],
        closeBatch: map['closeBatch'],
        closeBatchDate: map['closeBatchDate'],
        collId: map['collId'],
        collName: map['collName'],
        officeCode: map['officeCode'],
        officeName: map['officeName'],
      );

  factory ITrnLdvHeader.fromJson(String source) => ITrnLdvHeader.fromMap(json.decode(source));

  @override
  String toString() =>
      'ITrnLdvHeader(id: $id, ldvNo: $ldvNo, ldvDate: $ldvDate, closeBatch: $closeBatch, closeBatchDate: $closeBatchDate, collId: $collId, collName: $collName, officeCode: $officeCode, officeName: $officeName)';

  @override
  bool comparePk(a, b) => a.ldvNo == b.ldvNo;
}
