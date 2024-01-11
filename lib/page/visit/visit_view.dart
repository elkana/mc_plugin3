import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../../widget/common.dart';
import '../../widget/tabs/tabs.dart';
import 'kronologi/kronologi_view.dart';
import 'penerimaan/penerimaan_view.dart';
import 'visit_controller.dart';

class VisitView extends GetView<VisitController> {
  const VisitView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(
        title: 'Visit'.text.make(),
        actions: [
          IconButton(onPressed: controller.viewDatabase, icon: const Icon(Icons.storage_rounded)),
          IconButton(onPressed: controller.logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: FormBuilder(
          key: controller.formKey,
          initialValue: controller.initialValue.value?.toMap() ?? {},
          enabled: controller.formEnabled,
          child: TabsTop(
              titles: const [
                'Detil Kontrak',
                'Kronologi',
                'Penerimaan',
              ],
              controller: controller.tabController,
              children: [
                ContractView(controller.contractPk!),
                const KronologiView(),
                PenerimaanView(enabled: controller.formEnabled),
              ])),
      floatingActionButton: FloatingActionButton(onPressed: controller.submit));
}

class ContractView extends StatelessWidget {
  final LdvDetailPk pk;
  const ContractView(this.pk, {super.key});

  @override
  Widget build(context) => [
        KeyVal('No. Dokumen', '${pk.ldvNo}'),
        KeyVal('No. Contract', '${pk.contractNo}'),
        GetBuilder<VisitController>(
            builder: (c) =>
                '${OutboundLdvDetail().findByPk(c.contractPk!.ldvNo!, c.contractPk!.contractNo!)}'.text.make())
        // ValueListenableBuilder<Box<OTrnLdvDetail>>(
        //     valueListenable: OTrnLdvDetail().listenTable,
        //     builder: (context, obox, widget) {
        //       return '${obox.values.first}'.text.make();
        //     })
      ].column();
}
