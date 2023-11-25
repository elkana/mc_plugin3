import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstBank)
class MstBank extends HiveObject {
  static const syncTableName = 'mst_bank';

  @HiveField(0)
  int? id;
  @HiveField(1)
  int? seqNo;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? urlLogo;

  MstBank({
    this.id,
    this.code,
    this.seqNo,
    this.name,
    this.urlLogo,
  });

  static MstBank? scan(String? code, {List<MstBank>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstBank>(syncTableName).isEmpty;
  }

  static List<MstBank> findAll() {
    final box = Hive.box<MstBank>(syncTableName);
    return box.values.toList().cast<MstBank>();
  }

  static Future flush(List<MstBank>? data) async {
    if (data == null) return;

    final box = Hive.box<MstBank>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstBank>(syncTableName);

    await box.clear();
  }

  static MstBank? findByCode(String code) {
    List<MstBank> list = findAll();

    try {
      return list.where((e) => e.code == code).first;
    } catch (e) {
      return null;
    }
  }
}
