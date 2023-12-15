import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../provider/api.dart';
import 'abasic_controller.dart';

abstract class ASyncController extends ABasicController {
  Future get sync async {
    await Api.instance.setBatch();
    if (kDebugMode) await 5.delay();
  }
}
