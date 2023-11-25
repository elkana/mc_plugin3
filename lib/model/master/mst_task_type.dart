import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstTaskType)
class MstTaskType extends HiveObject {
  static const syncTableName = 'mst_tasktype';

  @HiveField(0)
  String? taskCode;

  @HiveField(1)
  String? shortDesc;

  @HiveField(2)
  String? fullDesc;

  MstTaskType({this.taskCode, this.shortDesc, this.fullDesc});

  static MstTaskType? scan(String? taskCode, {List<MstTaskType>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.taskCode == taskCode) {
        return f;
      }
    }

    return null;
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstTaskType>(syncTableName);

    await box.clear();
  }

  static Future flush(List<MstTaskType>? data) async {
    if (data == null) return;

    final box = Hive.box<MstTaskType>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.taskCode == null || d.taskCode!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static List<MstTaskType> findAll() {
    final box = Hive.box<MstTaskType>(syncTableName);
    return box.values.toList().cast<MstTaskType>();
  }
}
