import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../util/commons.dart';
import '../util/device_util.dart';
import 'abasic_controller.dart';

/// tidak diperutnukkan utk multiple forms
class AFormBuilderController extends ABasicController {
  var formKey = GlobalKey<FormBuilderState>();
  var dataChanged = false.obs;
  var title = ''.obs;

  void reset() => formKey.currentState?.reset();

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting(); // must
    ever<bool>(dataChanged, (callback) {
      if (!callback) errorCounter = 0;
    });
  }

  Future<bool> willPopScope() async {
    if (dataChanged.isTrue) return await confirm('Data belum disimpan. \nBatalkan ?');
    return true;
  }

  Future<bool> submit() async {
    if (!await DeviceUtil.allPermissionsGranted()) return false;

    if (!(formKey.currentState?.saveAndValidate() ?? false)) {
      log('validation FAILED form  ${formKey.currentState?.value}');
      return false;
    }
    log('(DataChanged=${dataChanged.value}) validation SUCCESS ${formKey.currentState?.value}');
    return true;
  }
}
