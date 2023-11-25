import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import '../../util/hive_util.dart';

@HiveType(typeId: HiveUtil.typeIdMstPaymentPoint)
class MstPaymentPoint extends HiveObject {
  static const syncTableName = 'mst_payment_point';

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
  @HiveField(5)
  String? barcode;
  @HiveField(6)
  int? barcodeWidth;
  @HiveField(7)
  int? barcodeHeight;

  MstPaymentPoint({
    this.id,
    this.code,
    this.seqNo,
    this.name,
    this.urlLogo,
    this.barcode,
    this.barcodeWidth,
    this.barcodeHeight,
  });

  static MstPaymentPoint? scan(String? code, {List<MstPaymentPoint>? list}) {
    //dilarang pake foreach
    for (var f in (list ?? findAll())) {
      if (f.code == code) {
        return f;
      }
    }

    return null;
  }

  static bool isEmpty() {
    return Hive.box<MstPaymentPoint>(syncTableName).isEmpty;
  }

  static List<MstPaymentPoint> findAll() {
    final box = Hive.box<MstPaymentPoint>(syncTableName);
    return box.values.toList().cast<MstPaymentPoint>();
  }

  static Future flush(List<MstPaymentPoint>? data) async {
    if (data == null) return;

    final box = Hive.box<MstPaymentPoint>(syncTableName);

    await box.clear();

    for (var d in data) {
      if (d.code == null || d.code!.trim().isEmpty) continue;
      box.add(d);
    }

    debugPrint('flushed ${box.values.toList().length} $syncTableName');
  }

  static Future cleanAll() async {
    debugPrint('cleanup $syncTableName');

    final box = Hive.box<MstPaymentPoint>(syncTableName);

    await box.clear();
  }

  static MstPaymentPoint? findByCode(String code) {
    List<MstPaymentPoint> list = findAll();

    try {
      return list.where((e) => e.code == code).first;
    } catch (e) {
      return null;
    }
  }
}
