import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

// @Table(name = "CM_MST_LKP_CLASSIFICATIONS", schema = "fifocm")
@HiveType(typeId: HiveUtil.typeIdMstLdvDocument)
class MstLDVDocument extends HiveObject {
  static const syncTableName = 'mst_ldv_documents';

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  int? seqNo;
  @HiveField(3)
  String? description;
  @HiveField(4)
  bool? visible;

  MstLDVDocument({this.id, this.code, this.seqNo, this.description, this.visible});

  static MstLDVDocument? scan(String code, List<MstLDVDocument> list) {
    //dilarang pake foreach
    for (var f in list) {
      if (f.description == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstLDVDocument>(syncTableName).isEmpty;
  }

  static List<MstLDVDocument> findAll() {
    final box = Hive.box<MstLDVDocument>(syncTableName);
    return box.values.toList().cast<MstLDVDocument>();
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstLDVDocument>(syncTableName);

    await box.clear();
  }

  static Future flush(List<MstLDVDocument>? data) async {
    if (data == null) return;

    final box = Hive.box<MstLDVDocument>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static MstLDVDocument? findByCode(String codeDocument) {
    List<MstLDVDocument> list = findAll();

    try {
      return list.where((e) => e.code == codeDocument).first;
    } catch (e) {
      return null;
    }
  }
}
