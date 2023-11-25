import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstLdvStatus)
class MstLdvStatus extends HiveObject {
  static const syncTableName = 'mst_ldv_status';

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  String? label;

  MstLdvStatus({this.id, this.code, this.label});

  static MstLdvStatus? scan(String? code, {List<MstLdvStatus>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstLdvStatus>(syncTableName).isEmpty;
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLdvStatus>(syncTableName);

    await box.clear();
  }

  static List<MstLdvStatus> findAll() {
    final box = Hive.box<MstLdvStatus>(syncTableName);
    return box.values.toList().cast<MstLdvStatus>();
  }

  static Future flush(List<MstLdvStatus>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLdvStatus>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }
}
