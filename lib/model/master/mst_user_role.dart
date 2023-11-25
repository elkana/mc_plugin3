import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstUserRole)
class MstUserRole extends HiveObject {
  static const syncTableName = 'mst_userrole';

  @HiveField(0)
  String? code;

  @HiveField(1)
  String? description;

  MstUserRole({this.code, this.description});

  static Future flush(List<MstUserRole>? data) async {
    if (data == null) return;

    final box = Hive.box(syncTableName);

    await box.clear();

    for (var d in data) {
      // hanya yg pk not null
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static MstUserRole? scan(String? code, {List<MstUserRole>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == code) {
        return f;
      }
    }
    return null;
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');
    final box = Hive.box<MstUserRole>(syncTableName);
    await box.clear();
  }

  static List<MstUserRole> findAll() {
    final box = Hive.box<MstUserRole>(syncTableName);
    return box.values.toList().cast<MstUserRole>();
  }
}
