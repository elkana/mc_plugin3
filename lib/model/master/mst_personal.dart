import 'dart:convert';

import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

part 'mst_personal.g.dart';

@HiveType(typeId: HiveUtil.typeIdMstPersonal)
class MstPersonal extends LocalTable<MstPersonal> {
  // static const syncTableName = 'mst_ldv_personal';

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? code;
  @HiveField(2)
  int? seqNo;
  @HiveField(3)
  String? description;
  MstPersonal({
    this.id,
    this.code,
    this.seqNo,
    this.description,
  });

  @override
  String toString() => '$description';

  @override
  // TODO: implement syncTableName
  String get syncTableName => 'mst_personal';

  // static MstPersonal? scan(String? code, {List<MstPersonal>? list}) {
  //   //dilarang pake foreach
  //   for (var f in (list ?? findAll())) {
  //     if (f.key == code || f.description == code) {
  //       return f;
  //     }
  //   }

  //   return null;
  // }

  // static bool isEmpty() {
  //   return Hive.box<MstPersonal>(syncTableName).isEmpty;
  // }

  // static Future cleanAll() async {
  //   debugPrint('cleanup $syncTableName');
  //   final box = Hive.box<MstPersonal>(syncTableName);
  //   await box.clear();
  // }

  // static List<MstPersonal> findAll() {
  //   final box = Hive.box<MstPersonal>(syncTableName);
  //   return box.values.toList().cast<MstPersonal>();
  // }

  // static Future flush(List<MstPersonal>? data) async {
  //   if (data == null) return;

  //   final box = Hive.box<MstPersonal>(syncTableName);

  //   await box.clear();

  //   for (var d in data) {
  //     if (d.key == null || d.key!.trim().isEmpty) continue;
  //     box.add(d);
  //   }

  //   debugPrint('flushed ${box.values.toList().length} $syncTableName');
  // }

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'seqNo': seqNo,
        'description': description,
      };

  factory MstPersonal.fromMap(Map<String, dynamic> map) => MstPersonal(
        id: map['id']?.toInt(),
        code: map['code'],
        seqNo: map['seqNo']?.toInt(),
        description: map['description'],
      );

  String toJson() => json.encode(toMap());

  factory MstPersonal.fromJson(String source) => MstPersonal.fromMap(json.decode(source));

  @override
  bool onPKCheck(MstPersonal a, MstPersonal b) => a.code == b.code;
}
