import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstLdvFlag)
class MstLdvFlag extends HiveObject {
  static const syncTableName = 'mst_ldv_flag';

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

  MstLdvFlag({this.id, this.code, this.label, this.workFlag, this.active});

  static MstLdvFlag? scan(String? code, List<MstLdvFlag> list) {
    //dilarang pake foreach
    for (var f in list) {
      if (f.code == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstLdvFlag>(syncTableName).isEmpty;
  }

  static List<MstLdvFlag> findAll() {
    final box = Hive.box<MstLdvFlag>(syncTableName);
    return box.values.toList().cast<MstLdvFlag>();
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLdvFlag>(syncTableName);

    await box.clear();
  }

  static Future flush(List<MstLdvFlag>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLdvFlag>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }
}
