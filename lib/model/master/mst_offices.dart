import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstOffice)
class MstOffice extends HiveObject {
  static const syncTableName = 'mst_office';

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? code;

  @HiveField(2)
  String? officeName;

  @HiveField(3)
  String? officeType;

  @HiveField(4)
  String? address1;

  @HiveField(5)
  String? address2;

  @HiveField(6)
  String? address3;

  @HiveField(7)
  String? city;

  @HiveField(8)
  String? phone1;

  @HiveField(9)
  String? namaKota;

  @HiveField(10)
  String? branchName;

  MstOffice(
      {this.id,
      this.code,
      this.officeName,
      this.officeType,
      this.address1,
      this.address2,
      this.city,
      this.phone1,
      this.namaKota,
      this.branchName});

  // need by searchable_dropdown
  @override
  String toString() {
    return '$officeName $code'.toLowerCase() + ' $officeName $code'.toUpperCase();
  }

  static MstOffice? scan(String? officeCode, {List<MstOffice>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == officeCode) {
        return f;
      }
    }

    return null;
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstOffice>(syncTableName);

    await box.clear();
  }

  static MstOffice? findOffice(String? officeCode) {
    for (var o in findAll()) {
      if (o.code == officeCode) return o;
    }

    return null;
  }
  // static MstOffice getOffice(String? officeCode, List<MstOffice> list) {
  //   if (officeCode == null || officeCode.trim().length < 1) return null;

  //   for (var o in list) {
  //     if (o.code == officeCode) return o;
  //   }

  //   return null;
  // }

  static Future flush(List<MstOffice>? data) async {
    if (data == null) return;

    final box = Hive.box<MstOffice>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static List<MstOffice> findAll() {
    final box = Hive.box<MstOffice>(syncTableName);

    // box.values.toList().forEach((element) {
    //   print(element);
    // });

    List<MstOffice> list = box.values.toList().cast<MstOffice>();
    // print('getOffices ada ${list.length}');
    return list;
  }
}
