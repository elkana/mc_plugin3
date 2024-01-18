import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../util/hive_util.dart';
part 'mc_photo.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnPhoto)
class TrnPhoto extends LocalTable<TrnPhoto> {
  // static const syncTableName = 'tbl_photo';

  @HiveField(0)
  String? id;
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
  Map<String, dynamic> toMap() {
    return {
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
  }

  factory TrnPhoto.fromMap(Map<String, dynamic> map) {
    return TrnPhoto(
      id: map['id'],
      officeId: map['officeId'],
      userId: map['userId'],
      sourceId: map['sourceId'],
      contractNo: map['contractNo'],
      photoId: map['photoId'],
      // blobPath: map['blobPath'], di core ga ada
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
    // }

    // @override
    // String toJson() => json.encode(toMap());

    // factory TblPhoto.fromJson(String source) => TblPhoto.fromMap(json.decode(source));

    // @override
    // String toString() {
    //   return 'TblPhoto(id: $id, officeId: $officeId, userId: $userId, sourceId: $sourceId, contractNo: $contractNo, photoId: $photoId, blobPath: $blobPath, fileName: $fileName, mimeType: $mimeType, rev1: $rev1, rev2: $rev2, label: $label, latitude: $latitude, longitude: $longitude, createdBy: $createdBy, createdDate: $createdDate, lastUpdateBy: $lastUpdateBy, lastUpdateDate: $lastUpdateDate)';
    // }

    // static ValueListenable<Box<TblPhoto>> listenTable() => Hive.box<TblPhoto>(TblPhoto.syncTableName).listenable();

    // static ValueListenable<Box<TblPhoto>> listenSomeData(List<dynamic>? keys) =>
    //     Hive.box<TblPhoto>(TblPhoto.syncTableName).listenable(keys: keys);

    // static Future flush(List<TblPhoto>? data) async {
    //   if (data == null) return;
    //   final box = Hive.box<TblPhoto>(syncTableName);
    //   await box.clear();
    //   for (var d in data) {
    //     await saveOrUpdate(d);
    //   }
    //   log('flushed ${box.values.toList().length} $syncTableName');
    // }

    // static TblPhoto? findById(String? uid) {
    //   List<TblPhoto> list = findAll();
    //   if (list.isEmpty) return null;
    //   try {
    //     return list.where((e) => e.id == uid).first;
    //   } catch (e) {
    //     return null;
    //   }
    // }

    // static TblPhoto? findPoABy(String? sourceId) {
    //   List<TblPhoto> list = findAll();
    //   if (list.isEmpty || sourceId == null) return null;
    //   try {
    //     var tmp = list.where((e) => e.sourceId.startsWith(sourceId) && e.photoId == PhotoType.repoPoA.fileKey).toList();
    //     // sort by sourceId
    //     tmp.sort((a, b) => b.sourceId.compareTo(a.sourceId));
    //     // e.sourceId == sourceId && e.photoId == PhotoType.repoPoA.fileKey)
    //     //ambil yg terakhir
    //     return tmp.first;
    //   } catch (e) {
    //     return null;
    //   }
    // }

    // static List<TblPhoto> findAll() {
    //   final box = Hive.box<TblPhoto>(syncTableName);
    //   var list = box.values.toList().cast<TblPhoto>();
    //   list.sort((a, b) => b.createdDate!.isoToLocalDate().compareTo(a.createdDate!.isoToLocalDate()));
    //   return list;
    // }

    // static Future cleanAll() async {
    //   final box = Hive.box<TblPhoto>(syncTableName);
    //   log('cleanup ${box.length} $syncTableName');
    //   await box.clear();
    // }

    // static bool isEmpty() => Hive.box<TblPhoto>(syncTableName).isEmpty;

    // static Future<List<TblPhoto>> saveOrUpdateAll(List<TblPhoto>? origin) async {
    //   if (null == origin) return [];
    //   var list = origin
    //       // .map((doc) => ProjectModel.fromMap(doc.data() as Map<String, dynamic>))
    //       .where((e) => true)
    //       .toList();
    //   log('RECEIVE ${list.length} $syncTableName');
    //   for (var e in list) {
    //     await TblPhoto.saveOrUpdate(e);
    //   }
    //   return list;
    // }

    // static Future<TblPhoto?> saveOrUpdate(TblPhoto? origin) async {
    //   if (null == origin) return null;
    //   final box = Hive.box<TblPhoto>(syncTableName);
    //   final Map<dynamic, TblPhoto> map = box.toMap();
    //   int? desiredKey;
    //   map.forEach((key, value) {
    //     if (value.id == origin.id) desiredKey = key;
    //   });
    //   // if no matched, insert
    //   if (desiredKey == null || origin.id == null) {
    //     origin.id ??= Utility.uuid(); // masih ragu2 apa perlu, ternyata perlu buat delete dah pasti pake id
    //     desiredKey = await box.add(origin);
    //     log('INSERT $syncTableName $origin with id = $desiredKey');
    //     // now e cant reuse key because it might change ?
    //     // origin.key = desiredKey!;
    //     await box.put(desiredKey, origin);
    //     return origin;
    //   }
    //   // bypass read message. if read, dont replace
    //   TblPhoto? oldData = box.get(desiredKey);
    //   // origin.readFlag = oldData!.readFlag;
    //   await box.put(desiredKey, origin);
    //   log('UPDATE $syncTableName $origin with key = $desiredKey');
    //   return origin;
    // }

    // static Future<bool> deleteData(TblPhoto? exist) async {
    //   if (null == exist) return false;
    //   final box = Hive.box<TblPhoto>(syncTableName);
    //   final Map<dynamic, TblPhoto> map = box.toMap();
    //   dynamic desiredKey;
    //   map.forEach((key, value) {
    //     if (value.id == exist.id) desiredKey = key;
    //   });
    //   if (desiredKey == null) return false;
    //   await box.delete(desiredKey);
    //   log('DELETE $syncTableName $exist with key = $desiredKey');
    //   return true;
    // }

    // static List<TblPhoto> findAllCollateral(String sktNo, String userId) =>
    //     findAll().where((e) => e.sourceId.startsWith('${sktNo}_') && e.userId == userId).toList();
  }

  // /// collateral photo use concat of sktNo with collateralNo
  // TrnPhoto? findBy(String sktNo, String collateralNo, String photoId, String userId) =>
  //     findByConcat('${sktNo}_$collateralNo', photoId, userId);

  TrnPhoto? findBy(String ldvNo, String photoId, String userId) {
    try {
      return findAll.where((e) => e.sourceId == ldvNo && e.photoId == photoId && e.userId == userId).first;
    } catch (e) {
      return null;
    }
  }

  @override
  bool comparePk(TrnPhoto a, TrnPhoto b) => a.id == b.id;
}
