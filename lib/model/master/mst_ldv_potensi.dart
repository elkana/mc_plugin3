import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstLdvPotensi)
class MstLdvPotensi extends HiveObject {
  static const syncTableName = 'mst_ldv_potensi';

  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  int? potensi;
  @HiveField(3)
  String? potensiDescription;
  @HiveField(4)
  String? delqId;
  @HiveField(5)
  String? classCode;

  MstLdvPotensi({this.id, this.seqNo, this.potensi, this.potensiDescription, this.delqId, this.classCode});

  static MstLdvPotensi? scan(int? potensi, {List<MstLdvPotensi>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.potensi == potensi) {
        return f;
      }
    }

    return null;
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLdvPotensi>(syncTableName);

    await box.clear();
  }

  static bool isEmpty() {
    return Hive.box<MstLdvPotensi>(syncTableName).isEmpty;
  }

  static List<MstLdvPotensi> findAll() {
    final box = Hive.box<MstLdvPotensi>(syncTableName);

    List<MstLdvPotensi> list = box.values.toList().cast<MstLdvPotensi>();
    return list;
  }

  static Future flush(List<MstLdvPotensi>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLdvPotensi>(syncTableName);

    await box.clear();

    for (var d in data) {
      // if (d.potensi == null || d.potensi.trim().length < 1) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static List<MstLdvPotensi> findByDelqAndClassification(String? delqCode, String? classCode,
      {List<MstLdvPotensi>? list}) {
    List<MstLdvPotensi> buffer = [];
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.classCode == classCode && f.delqId == delqCode) {
        buffer.add(f);
      }
    }

    return buffer;
  }
}
