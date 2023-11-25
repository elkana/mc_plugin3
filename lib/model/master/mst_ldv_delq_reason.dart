import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstLdvDelqReason)
class MstLdvDelqReason extends HiveObject {
  static const syncTableName = 'mst_ldv_delq_reason';

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

  MstLdvDelqReason({this.id, this.seqNo, this.code, this.label, this.description, this.visible});

  static MstLdvDelqReason? scan(String? code, {List<MstLdvDelqReason>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstLdvDelqReason>(syncTableName).isEmpty;
  }

  static List<MstLdvDelqReason> findAll() {
    final box = Hive.box<MstLdvDelqReason>(syncTableName);
    return box.values.toList().cast<MstLdvDelqReason>();
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLdvDelqReason>(syncTableName);

    await box.clear();
  }

  static Future flush(List<MstLdvDelqReason>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLdvDelqReason>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }
}
