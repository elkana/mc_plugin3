import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/abasic_controller.dart';

import '../../../routes/app_routes.dart';

class PoaBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<PoaController>(() => PoaController());
}

class PoaController extends ABasicController {
  Future takePhoto() async {
    Navigator.of(Get.context!).pop('ok');
  }
}
