import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../util/commons.dart';
import 'abasic_controller.dart';
import 'auth_controller.dart';

/// tidak diperutnukkan utk multiple forms
abstract class AFormBuilderController extends ABasicController {
  var formKey = GlobalKey<FormBuilderState>();
  var dataChanged = false.obs;
  var title = ''.obs;
  // use submitting to hold in progress while saving to avoid double submit
  var submitting = false.obs;

  dynamic get formChanges => formKey.currentState?.value ?? {};
  void reset() => formKey.currentState?.reset();
  // main method to process form data and wrote to disk when needed
  Future onSubmit();

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
    // check permissions again
    if (AuthController.instance.loggedUser == null) {
      showError('Please Login.');
      return false;
    }
    if (!await validateAllPermissions()) {
      showError('Maaf, Anda harus menyetujui akses ke perangkat.');
      return false;
    }
    if (!(formKey.currentState?.saveAndValidate() ?? false)) {
      log('validation FAILED form  ${formKey.currentState?.value}');
      return false;
    }
    log('(DataChanged=${dataChanged.value}) validation SUCCESS ${formKey.currentState?.value}');

    submitting(true);
    try {
      await onSubmit();

      dataChanged(false);
      // finally, update cache
      // Navigator.pop(Get.context!, [resp]);
      return true;
    } catch (e, s) {
      if (e is DioException && e.response?.statusCode == 403) {
        AuthController.instance.logout();
        throw Exception('Session Timeout. please relogin');
      }
      showError(e, stacktrace: s);
    } finally {
      submitting(false);
    }
    return false;
  }
}

abstract class ATabFormController extends AFormBuilderController {
  late TabController tabController;

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
