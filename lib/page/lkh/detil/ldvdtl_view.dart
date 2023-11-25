import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../widget/common.dart';
import 'ldvdtl_controller.dart';

class LdvDetilView extends GetView<LdvDetilController> {
  const LdvDetilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: controller.willPopScope,
      child: Scaffold(
          body: [
        '-- Debug Info --\n${controller.outbound}'.text.xs.make().hide(isVisible: kDebugMode),
        FormBuilder(
                key: controller.formKey,
                initialValue: controller.inbound?.toMap() ?? {},
                // krn ada tabbar, ga bisa lagi pakai customscrollview, krn kena error constraint height
                child: [
                  'abc'.text.make(),
                  FormBuilderTextField(
                    name: 'workStatus',
// bisa nambah validasi seperti email/telpon dll...
                  )
                ].column())
            .expand(),
        [
          OutlinedButton(onPressed: controller.reset, child: 'Reset'.text.make()).expand(),
          MyButton('Submit', height: 42, onTap: controller.submit).expand(),
        ].row(alignment: MainAxisAlignment.spaceEvenly),
      ].column()));
}
