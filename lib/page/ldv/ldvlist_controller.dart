import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/abasic_controller.dart';
import '../../provider/api.dart';
import '../../util/hive_util.dart';

class LdvListBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LdvListController>(() => LdvListController());
}

class LdvListController extends AViewController {
  final scrollAktif = ScrollController();

  @override
  Future refreshData() => processThis(() => Api.instance.assignments);

  Future resetData() async {
    await HiveUtil.cleanAll(true);
    await refreshData();
  }
}
