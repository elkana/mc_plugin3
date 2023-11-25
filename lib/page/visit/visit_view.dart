import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/model/trn_lkp_dtl/o_trn_lkp_dtl.dart';
import 'package:mc_plugin3/widget/common.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:

import '../../model/master/mst_personal.dart';
import '../../widget/tabs/tabs.dart';
import 'visit_controller.dart';

class VisitView extends GetView<VisitController> {
  const VisitView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: 'Visit'.text.make()),
      body: TabsTop(
          titles: const [
            'Detil Kontrak',
            'Kronologi',
            'Penerimaan',
          ],
          controller: controller.tabController,
          children: [
            ContractView(controller.contractPk!),
            const KronologiView(),
            const PenerimaanView(),
          ]));
}

class ContractView extends StatelessWidget {
  final LdvDetailPk pk;
  const ContractView(this.pk, {super.key});

  @override
  Widget build(context) => [
        KeyVal('No. Dokumen', '${pk.ldvNo}'),
        KeyVal('No. Contract', '${pk.contractNo}'),
      ].column();
}

class KronologiView extends StatelessWidget {
  const KronologiView({super.key});

  @override
  Widget build(context) => [
        'Bertemu Dengan'.text.make(),
        FormBuilderDropdown<MstPersonal>(
            name: 'dropdown',
            items: MstPersonal()
                .findAll()
                .map((option) => DropdownMenuItem(value: option, child: Text(option.description ?? '')))
                .toList()),
        'Komentar'.text.make(),
        // 'Komentar'.remarks.make(),
        // 'Alasan'.dropDown.make(),
        // 'Klasifikasi'.dropDown.make(),
        // 'Tindakan Selanjutnya'.dropDown.make(),
        // 'Mobile Phone'.phoneNumber.make(),
      ].column();
}

class PenerimaanView extends StatelessWidget {
  const PenerimaanView({super.key});

  @override
  Widget build(context) => [
        'Penerimaan'.text.make(),
        'Kode Struk'.text.make(),
      ].column();
}
