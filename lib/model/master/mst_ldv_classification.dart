import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstLdvClassification)
class MstLdvClassification extends HiveObject {
  static const syncTableName = 'mst_ldv_classification';

  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? label;
  @HiveField(4)
  bool? visible;

  MstLdvClassification({this.id, this.seqNo, this.code, this.label, this.visible});

  static MstLdvClassification? scan(String? code, {List<MstLdvClassification>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstLdvClassification>(syncTableName).isEmpty;
  }

  static List<MstLdvClassification> findAll() {
    final box = Hive.box<MstLdvClassification>(syncTableName);
    return box.values.toList().cast<MstLdvClassification>();
  }

  static Future flush(List<MstLdvClassification>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLdvClassification>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLdvClassification>(syncTableName);

    await box.clear();
  }
}
