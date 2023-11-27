import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mc_plugin3/util/commons.dart';

import '../../util/hive_util.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs
part 'masters.g.dart';

// ALL IN ONE FILE, FIRST TIME SETUP, COPY & PASTE FOR EASY UPGRADE/DISTRIBUTIONS
// TO GENERATE SERIALIZATION, use Dart Data Class Generator extension to help you saving time.
// int? id is needed to simplify data updates
@HiveType(typeId: HiveUtil.typeIdMstPersonal)
class MstLdvPersonal extends LocalTable<MstLdvPersonal> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  int? seqNo;
  @HiveField(3)
  String? description;
  MstLdvPersonal({
    this.id,
    this.code,
    this.seqNo,
    this.description,
  }) : super('mst_ldv_personal');

  @override
  String toString() => '$description';

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'seqNo': seqNo,
        'description': description,
      };

  factory MstLdvPersonal.fromMap(Map<String, dynamic> map) => MstLdvPersonal(
        id: map['id']?.toInt(),
        code: map['code'],
        seqNo: map['seqNo']?.toInt(),
        description: map['description'],
      );

  factory MstLdvPersonal.fromJson(String source) => MstLdvPersonal.fromMap(json.decode(source));

  @override
  bool comparePk(a, b) => a.code == b.code;

  MstLdvPersonal? findByPk(String? value) {
    if (value == null) return null;
    return findAll().firstWhereOrNull((p0) => p0.code == value);
  }
}

@HiveType(typeId: HiveUtil.typeIdMstLdvPotensi)
class MstLdvPotensi extends LocalTable<MstLdvPotensi> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  int? potensi;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? delqId;
  @HiveField(5)
  String? classCode;
  MstLdvPotensi({
    this.id,
    this.seqNo,
    this.potensi,
    this.description,
    this.delqId,
    this.classCode,
  }) : super('mst_ldv_potensi');

  @override
  bool comparePk(a, b) => a.potensi == b.potensi;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'seqNo': seqNo,
        'potensi': potensi,
        'description': description,
        'delqId': delqId,
        'classCode': classCode,
      };

  factory MstLdvPotensi.fromMap(Map<String, dynamic> map) => MstLdvPotensi(
        id: map['id']?.toInt(),
        seqNo: map['seqNo']?.toInt(),
        potensi: map['potensi']?.toInt(),
        description: map['description'],
        delqId: map['delqId'],
        classCode: map['classCode'],
      );

  factory MstLdvPotensi.fromJson(String source) => MstLdvPotensi.fromMap(json.decode(source));

  @override
  String toString() =>
      'MstLdvPotensi(id: $id, seqNo: $seqNo, potensi: $potensi, description: $description, delqId: $delqId, classCode: $classCode)';
}

@HiveType(typeId: HiveUtil.typeIdMstLdvFlag)
class MstLdvFlag extends LocalTable<MstLdvFlag> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  String? label;
  @HiveField(3)
  String? workFlag;
  @HiveField(4)
  bool? active;
  MstLdvFlag({
    this.id,
    this.code,
    this.label,
    this.workFlag,
    this.active,
  }) : super('mst_ldv_flag');

  @override
  bool comparePk(a, b) => a.code == b.code;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'label': label,
        'workFlag': workFlag,
        'active': active,
      };

  factory MstLdvFlag.fromMap(Map<String, dynamic> map) => MstLdvFlag(
        id: map['id']?.toInt(),
        code: map['code'],
        label: map['label'],
        workFlag: map['workFlag'],
        active: map['active'],
      );

  factory MstLdvFlag.fromJson(String source) => MstLdvFlag.fromMap(json.decode(source));

  @override
  String toString() => 'MstLdvFlag(id: $id, code: $code, label: $label, workFlag: $workFlag, active: $active)';
}

@HiveType(typeId: HiveUtil.typeIdMstLdvDelqReason)
class MstLdvDelqReason extends LocalTable<MstLdvDelqReason> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? label;
  @HiveField(4)
  String? description;
  @HiveField(5)
  bool? visible;
  MstLdvDelqReason({
    this.id,
    this.seqNo,
    this.code,
    this.label,
    this.description,
    this.visible,
  }) : super('mst_ldv_delq_reason');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'seqNo': seqNo,
        'code': code,
        'label': label,
        'description': description,
        'visible': visible,
      };

  factory MstLdvDelqReason.fromMap(Map<String, dynamic> map) => MstLdvDelqReason(
        id: map['id']?.toInt(),
        seqNo: map['seqNo']?.toInt(),
        code: map['code'],
        label: map['label'],
        description: map['description'],
        visible: map['visible'],
      );

  factory MstLdvDelqReason.fromJson(String source) => MstLdvDelqReason.fromMap(json.decode(source));

  @override
  String toString() =>
      'MstLdvDelqReason(id: $id, seqNo: $seqNo, code: $code, label: $label, description: $description, visible: $visible)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstLdvClassification)
class MstLdvClassification extends LocalTable<MstLdvClassification> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? label;
  @HiveField(4)
  bool? visible;
  MstLdvClassification({
    this.id,
    this.seqNo,
    this.code,
    this.label,
    this.visible,
  }) : super('mst_ldv_classification');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'seqNo': seqNo,
        'code': code,
        'label': label,
        'visible': visible,
      };

  factory MstLdvClassification.fromMap(Map<String, dynamic> map) => MstLdvClassification(
        id: map['id']?.toInt(),
        seqNo: map['seqNo']?.toInt(),
        code: map['code'],
        label: map['label'],
        visible: map['visible'],
      );

  factory MstLdvClassification.fromJson(String source) => MstLdvClassification.fromMap(json.decode(source));

  @override
  String toString() => 'MstLdvClassification(id: $id, seqNo: $seqNo, code: $code, label: $label, visible: $visible)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstLdvNextAction)
class MstLdvNextAction extends LocalTable<MstLdvNextAction> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? label;
  @HiveField(4)
  String? notes;
  MstLdvNextAction({
    this.id,
    this.seqNo,
    this.code,
    this.label,
    this.notes,
  }) : super('mst_ldv_next_action');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'seqNo': seqNo,
        'code': code,
        'label': label,
        'notes': notes,
      };

  factory MstLdvNextAction.fromMap(Map<String, dynamic> map) => MstLdvNextAction(
        id: map['id']?.toInt(),
        seqNo: map['seqNo']?.toInt(),
        code: map['code'],
        label: map['label'],
        notes: map['notes'],
      );

  factory MstLdvNextAction.fromJson(String source) => MstLdvNextAction.fromMap(json.decode(source));

  @override
  String toString() => 'MstLdvNextAction(id: $id, seqNo: $seqNo, key: $key, label: $label, notes: $notes)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstLdvStatus)
class MstLdvStatus extends LocalTable<MstLdvStatus> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  String? label;
  MstLdvStatus({
    this.id,
    this.code,
    this.label,
  }) : super('mst_ldv_status');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'label': label,
      };

  factory MstLdvStatus.fromMap(Map<String, dynamic> map) => MstLdvStatus(
        id: map['id']?.toInt(),
        code: map['code'],
        label: map['label'],
      );

  factory MstLdvStatus.fromJson(String source) => MstLdvStatus.fromMap(json.decode(source));

  @override
  String toString() => 'MstStatus(id: $id, code: $code, label: $label)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstLdvDocument)
class MstDocument extends LocalTable<MstDocument> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  int? seqNo;
  @HiveField(3)
  String? description;
  @HiveField(4)
  bool? visible;
  MstDocument({
    this.id,
    this.code,
    this.seqNo,
    this.description,
    this.visible,
  }) : super('mst_ldv_documents');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'seqNo': seqNo,
        'description': description,
        'visible': visible,
      };

  factory MstDocument.fromMap(Map<String, dynamic> map) => MstDocument(
        id: map['id']?.toInt(),
        code: map['code'],
        seqNo: map['seqNo']?.toInt(),
        description: map['description'],
        visible: map['visible'],
      );

  factory MstDocument.fromJson(String source) => MstDocument.fromMap(json.decode(source));

  @override
  String toString() => 'MstDocument(id: $id, code: $code, seqNo: $seqNo, description: $description, visible: $visible)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstBank)
class MstBank extends LocalTable<MstBank> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? urlLogo;
  MstBank({
    this.id,
    this.seqNo,
    this.code,
    this.name,
    this.urlLogo,
  }) : super('mst_bank');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'seqNo': seqNo,
        'code': code,
        'name': name,
        'urlLogo': urlLogo,
      };

  factory MstBank.fromMap(Map<String, dynamic> map) => MstBank(
        id: map['id']?.toInt(),
        seqNo: map['seqNo']?.toInt(),
        code: map['code'],
        name: map['name'],
        urlLogo: map['urlLogo'],
      );

  factory MstBank.fromJson(String source) => MstBank.fromMap(json.decode(source));

  @override
  String toString() => 'MstBank(id: $id, seqNo: $seqNo, code: $code, name: $name, urlLogo: $urlLogo)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstOffice)
class MstOffice extends LocalTable<MstOffice> {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? code;

  @HiveField(2)
  String? officeName;

  @HiveField(3)
  String? officeType;

  @HiveField(4)
  String? address1;

  @HiveField(5)
  String? address2;

  @HiveField(6)
  String? address3;

  @HiveField(7)
  String? city;

  @HiveField(8)
  String? phone1;

  @HiveField(9)
  String? namaKota;

  @HiveField(10)
  String? branchName;
  MstOffice({
    this.id,
    this.code,
    this.officeName,
    this.officeType,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.phone1,
    this.namaKota,
    this.branchName,
  }) : super('mst_office');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'officeName': officeName,
        'officeType': officeType,
        'address1': address1,
        'address2': address2,
        'address3': address3,
        'city': city,
        'phone1': phone1,
        'namaKota': namaKota,
        'branchName': branchName,
      };

  factory MstOffice.fromMap(Map<String, dynamic> map) => MstOffice(
        id: map['id']?.toInt(),
        code: map['code'],
        officeName: map['officeName'],
        officeType: map['officeType'],
        address1: map['address1'],
        address2: map['address2'],
        address3: map['address3'],
        city: map['city'],
        phone1: map['phone1'],
        namaKota: map['namaKota'],
        branchName: map['branchName'],
      );

  factory MstOffice.fromJson(String source) => MstOffice.fromMap(json.decode(source));

  @override
  String toString() =>
      'MstOffice(id: $id, code: $code, officeName: $officeName, officeType: $officeType, address1: $address1, address2: $address2, address3: $address3, city: $city, phone1: $phone1, namaKota: $namaKota, branchName: $branchName)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstPaymentPoint)
class MstPaymentPoint extends LocalTable<MstPaymentPoint> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? urlLogo;
  @HiveField(5)
  String? barcode;
  @HiveField(6)
  int? barcodeWidth;
  @HiveField(7)
  int? barcodeHeight;
  MstPaymentPoint({
    this.id,
    this.seqNo,
    this.code,
    this.name,
    this.urlLogo,
    this.barcode,
    this.barcodeWidth,
    this.barcodeHeight,
  }) : super('mst_payment_point');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'seqNo': seqNo,
        'code': code,
        'name': name,
        'urlLogo': urlLogo,
        'barcode': barcode,
        'barcodeWidth': barcodeWidth,
        'barcodeHeight': barcodeHeight,
      };

  factory MstPaymentPoint.fromMap(Map<String, dynamic> map) => MstPaymentPoint(
        id: map['id']?.toInt(),
        seqNo: map['seqNo']?.toInt(),
        code: map['code'],
        name: map['name'],
        urlLogo: map['urlLogo'],
        barcode: map['barcode'],
        barcodeWidth: map['barcodeWidth']?.toInt(),
        barcodeHeight: map['barcodeHeight']?.toInt(),
      );

  factory MstPaymentPoint.fromJson(String source) => MstPaymentPoint.fromMap(json.decode(source));

  @override
  String toString() =>
      'MstPaymentPoint(id: $id, seqNo: $seqNo, code: $code, name: $name, urlLogo: $urlLogo, barcode: $barcode, barcodeWidth: $barcodeWidth, barcodeHeight: $barcodeHeight)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstTaskType)
class MstTaskType extends LocalTable<MstTaskType> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  String? shortDesc;
  @HiveField(3)
  String? fullDesc;
  MstTaskType({
    this.id,
    this.code,
    this.shortDesc,
    this.fullDesc,
  }) : super('mst_tasktype');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'shortDesc': shortDesc,
        'fullDesc': fullDesc,
      };

  factory MstTaskType.fromMap(Map<String, dynamic> map) => MstTaskType(
        id: map['id']?.toInt(),
        code: map['code'],
        shortDesc: map['shortDesc'],
        fullDesc: map['fullDesc'],
      );

  factory MstTaskType.fromJson(String source) => MstTaskType.fromMap(json.decode(source));

  @override
  String toString() => 'MstTaskType(id: $id, code: $code, shortDesc: $shortDesc, fullDesc: $fullDesc)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}

@HiveType(typeId: HiveUtil.typeIdMstUserRole)
class MstUserRole extends LocalTable<MstUserRole> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  String? description;
  MstUserRole({
    this.id,
    this.code,
    this.description,
  }) : super('mst_userrole');

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'description': description,
      };

  factory MstUserRole.fromMap(Map<String, dynamic> map) => MstUserRole(
        id: map['id']?.toInt(),
        code: map['code'],
        description: map['description'],
      );

  factory MstUserRole.fromJson(String source) => MstUserRole.fromMap(json.decode(source));

  @override
  String toString() => 'MstUserRole(id: $id, code: $code, description: $description)';

  @override
  bool comparePk(a, b) => a.code == b.code;
}
