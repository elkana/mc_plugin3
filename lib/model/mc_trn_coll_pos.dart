import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../util/commons.dart';
import '../util/hive_util.dart';

part 'mc_trn_coll_pos.g.dart';

@HiveType(typeId: HiveUtil.typeIdTrnCollPos)
class TrnCollPos extends LocalTable<TrnCollPos> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? uid;
  @HiveField(2)
  String? userId;
  @HiveField(3)
  String? latitude;
  @HiveField(4)
  String? longitude;
  @HiveField(5)
  String? lastUpdateDate;
  @HiveField(6)
  String? lastSyncDate;
  @HiveField(7)
  String? permissionType;
  @HiveField(8)
  String? logMethod;
  TrnCollPos({
    this.id,
    this.uid,
    this.userId,
    this.latitude,
    this.longitude,
    this.lastUpdateDate,
    this.lastSyncDate,
    this.permissionType,
    this.logMethod,
  }) : super('trn_coll_pos');

  @override
  bool comparePk(a, b) => a.uid == b.uid;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdateDate': lastUpdateDate,
      'lastSyncDate': lastSyncDate,
      'permissionType': permissionType,
      'logMethod': logMethod,
    };
  }

  factory TrnCollPos.fromMap(Map<String, dynamic> map) {
    return TrnCollPos(
      id: map['id']?.toInt(),
      uid: map['uid'],
      userId: map['userId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      lastUpdateDate: map['lastUpdateDate'],
      lastSyncDate: map['lastSyncDate'],
      permissionType: map['permissionType'],
      logMethod: map['logMethod'],
    );
  }
  factory TrnCollPos.fromJson(String source) => TrnCollPos.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TrnCollPos(id: $id, uid: $uid, userId: $userId, latitude: $latitude, longitude: $longitude, lastUpdateDate: $lastUpdateDate, lastSyncDate: $lastSyncDate, permissionType: $permissionType, logMethod: $logMethod)';
  }

  static Future<TrnCollPos> generateDraft(String logMethod) async {
    var permission = await Geolocator.checkPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var saved = TrnCollPos()
      ..uid = Utility.uuid()
      ..userId = 'elkana911'
      ..lastUpdateDate = DateTime.now().toIso8601String()
      ..logMethod = logMethod
      ..permissionType = permission.toString();

    if (serviceEnabled && (permission == LocationPermission.always || permission == LocationPermission.whileInUse)) {
      var ll = await Geolocator.getCurrentPosition();
      saved.latitude = ll.latitude.toString();
      saved.longitude = ll.longitude.toString();
    }

    return saved;
  }

  Future<TrnCollPos?> newData(String logMethod) async => await saveOne(await generateDraft(logMethod));

// mark gps into json file
// see cacheToTable
  static writeToCache() async {
    var saved = await generateDraft('Background');
    // if not, write to cache
    if (!kIsWeb) {
      var dir = await getApplicationDocumentsDirectory();
      final file = await io.File('${dir.path}/gps_${saved.uid}.json').create();
      // final file = await File('${tempDir.path}/struk_${collId}_$contractNo.png').create();
      await file.writeAsString(saved.toJson(), flush: true);
      log('GPS flushed to ${file.path}');
    }
  }

  // load json files into hive table
// see writeToCache
  static cacheToTable() async {
    var dir = await getApplicationDocumentsDirectory();
    var list = io.Directory('${dir.path}/').listSync().where((file) => p.extension(file.path) == '.json').toList();
    for (var f in list) {
      // RegExp regExp = RegExp('\\.(gif|jpe?g|tiff?|png|webp|bmp|json)', caseSensitive: false);
      var json = (f as io.File).readAsStringSync();
      var map = TrnCollPos.fromJson(json);
      await TrnCollPos().saveOne(map);
      // hapus
      f.deleteSync();
    }
  }
}
