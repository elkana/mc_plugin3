import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstLdvNextAction)
class MstLdvNextAction extends HiveObject {
  static const syncTableName = 'mst_ldv_next_action';

  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @override
  @HiveField(2)
  String? key;
  @HiveField(3)
  String? label;
  @HiveField(4)
  String? notes;

  MstLdvNextAction({this.id, this.seqNo, this.key, this.label, this.notes});

  static MstLdvNextAction? scan(String? code, {List<MstLdvNextAction>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.key == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstLdvNextAction>(syncTableName).isEmpty;
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLdvNextAction>(syncTableName);

    await box.clear();
  }

  static List<MstLdvNextAction> findAll() {
    final box = Hive.box<MstLdvNextAction>(syncTableName);
    return box.values.toList().cast<MstLdvNextAction>();
  }

  static Future flush(List<MstLdvNextAction>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLdvNextAction>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.key == null || d.key!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }
}
