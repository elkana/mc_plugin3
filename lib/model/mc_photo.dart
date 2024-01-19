import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../util/hive_util.dart';

part 'mc_photo.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnPhoto)
class TrnPhoto extends LocalTable<TrnPhoto> {
  // static const syncTableName = 'tbl_photo';

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? officeId;
  @HiveField(2)
  String? userId;
  @HiveField(3)
  String? sourceId;
  @HiveField(4)
  String? contractNo;
  @HiveField(5)
  String? photoId;
  // disediakan utk web. null jika mobile
  @HiveField(6)
  String? blobPath;
  @HiveField(7)
  String? fileName;
  @HiveField(8)
  String? mimeType;
  @HiveField(9)
  String? rev1;
  @HiveField(10)
  String? rev2;
  @HiveField(11)
  String? label;
  @HiveField(12)
  String? latitude;
  @HiveField(13)
  String? longitude;
  @HiveField(14)
  String? createdBy;
  @HiveField(15)
  String? createdDate;
  @HiveField(16)
  String? lastUpdateBy;
  @HiveField(17)
  String? lastUpdateDate;
  TrnPhoto({
    this.id,
    this.sourceId, // required
    this.photoId, //required
    this.fileName, //required
    this.officeId,
    this.userId,
    this.contractNo,
    this.blobPath,
    this.mimeType,
    this.rev1,
    this.rev2,
    this.label,
    this.latitude,
    this.longitude,
    this.createdBy,
    this.createdDate,
    this.lastUpdateBy,
    this.lastUpdateDate,
  }) : super('trn_photo');

  @override
  String toString() =>
      'TrnPhoto(id: $id, officeId: $officeId, userId: $userId, sourceId: $sourceId, contractNo: $contractNo, photoId: $photoId, blobPath: $blobPath, fileName: $fileName, mimeType: $mimeType, rev1: $rev1, rev2: $rev2, label: $label, latitude: $latitude, longitude: $longitude, createdBy: $createdBy, createdDate: $createdDate, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate)';
  // /// collateral photo use concat of sktNo with collateralNo
  // TrnPhoto? findBy(String sktNo, String collateralNo, String photoId, String userId) =>
  //     findByConcat('${sktNo}_$collateralNo', photoId, userId);

  TrnPhoto? findByPk(String ldvNo, String photoId, String userId) {
    try {
      return findAll.where((e) => e.sourceId == ldvNo && e.photoId == photoId && e.userId == userId).first;
    } catch (e) {
      return null;
    }
  }

  @override
  bool comparePk(TrnPhoto a, TrnPhoto b) =>
      a.sourceId == b.sourceId && a.photoId == b.photoId && a.fileName == b.fileName;

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'officeId': officeId,
        'userId': userId,
        'sourceId': sourceId,
        'contractNo': contractNo,
        'photoId': photoId,
        'blobPath': blobPath,
        'fileName': fileName,
        'mimeType': mimeType,
        'rev1': rev1,
        'rev2': rev2,
        'label': label,
        'latitude': latitude,
        'longitude': longitude,
        'createdBy': createdBy,
        'createdDate': createdDate,
        'lastUpdateBy': lastUpdateBy,
        'lastUpdateDate': lastUpdateDate,
      };

  factory TrnPhoto.fromMap(Map<String, dynamic> map) => TrnPhoto(
        id: map['id']?.toInt(),
        officeId: map['officeId'],
        userId: map['userId'],
        sourceId: map['sourceId'],
        contractNo: map['contractNo'],
        photoId: map['photoId'],
        blobPath: map['blobPath'],
        fileName: map['fileName'],
        mimeType: map['mimeType'],
        rev1: map['rev1'],
        rev2: map['rev2'],
        label: map['label'],
        latitude: map['latitude'],
        longitude: map['longitude'],
        createdBy: map['createdBy'],
        createdDate: map['createdDate'],
        lastUpdateBy: map['lastUpdateBy'],
        lastUpdateDate: map['lastUpdateDate'],
      );

  factory TrnPhoto.fromJson(String source) => TrnPhoto.fromMap(json.decode(source));
}
