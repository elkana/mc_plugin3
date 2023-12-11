import 'package:mc_plugin3/controller/abasic_controller.dart';
import 'package:mc_plugin3/model/mc_trn_rvcollcomment.dart';

import '../provider/api.dart';
import '../util/commons.dart';

abstract class ASyncController extends ABasicController {
  Future get sync async {
    TrnRVCollComment().findAll.forEach((e) async {
      log('try upload $e');
      await Api.instance.setTrnRVCollComment(e);
    });
  }
}
