import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:
import '../../model/masters.dart';
import '../../model/trn_ldv_dtl/o_trn_ldv_dtl.dart';
import '../../widget/common.dart';
import '../../widget/tabs/tabs.dart';
import 'visit_controller.dart';

class VisitView extends GetView<VisitController> {
  const VisitView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: 'Visit'.text.make(),
          actions: [
            IconButton(onPressed: controller.viewDatabase, icon: const Icon(Icons.storage_rounded)),
            // IconButton(onPressed: controller.resetData, icon: const Icon(Icons.restore_page)),
          ],
        ),
        body: FormBuilder(
          key: controller.formKey,
          initialValue: controller.initialValue.value?.toMap() ?? {},
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
                const PenerimaanView(),
              ]),
        ),
        floatingActionButton: FloatingActionButton(onPressed: controller.submit),
      );
}

class ContractView extends StatelessWidget {
  final LdvDetailPk pk;
  const ContractView(this.pk, {super.key});

  @override
  Widget build(context) => [
        KeyVal('No. Dokumen', '${pk.ldvNo}'),
        KeyVal('No. Contract', '${pk.contractNo}'),
        GetBuilder<VisitController>(
            builder: (cont) =>
                '${OTrnLdvDetail().findByPk(cont.contractPk!.ldvNo!, cont.contractPk!.contractNo!)}'.text.make())
        // ValueListenableBuilder<Box<OTrnLdvDetail>>(
        //     valueListenable: OTrnLdvDetail().listenTable,
        //     builder: (context, obox, widget) {
        //       return '${obox.values.first}'.text.make();
        //     })
      ].column();
}

class KronologiView extends StatelessWidget {
  const KronologiView({super.key});

  @override
  Widget build(context) => GetX<VisitController>(
      builder: (cont) => [
            FormBuilderDropdown<MstLdvPersonal>(
                name: 'whoMet',
                decoration: InputDecoration(label: 'Bertemu Dengan'.text.make()),
                initialValue: MstLdvPersonal().findByPk(cont.initialValue.value?.whoMet),
                onChanged: (val) => cont.dataChanged(true),
                valueTransformer: (val) => val?.code,
                items: MstLdvPersonal()
                    .findAll()
                    .map((option) => DropdownMenuItem(value: option, child: Text(option.description ?? '')))
                    .toList()),
            FormBuilderDropdown<MstLdvDelqReason>(
                name: 'delqCode',
                decoration: InputDecoration(label: 'Alasan'.text.make()),
                initialValue: MstLdvDelqReason().findByPk(cont.initialValue.value?.delqCode),
                onChanged: (val) => cont.dataChanged(true),
                valueTransformer: (val) => val?.code,
                items: MstLdvDelqReason()
                    .findAll()
                    .map((option) => DropdownMenuItem(value: option, child: Text(option.description ?? '')))
                    .toList()),
            FormBuilderDropdown<MstLdvClassification>(
                name: 'classCode',
                decoration: InputDecoration(label: 'Klasifikasi'.text.make()),
                initialValue: MstLdvClassification().findByPk(cont.initialValue.value?.classCode),
                onChanged: (val) => cont.dataChanged(true),
                valueTransformer: (val) => val?.code,
                items: MstLdvClassification()
                    .findAll()
                    .map((option) => DropdownMenuItem(value: option, child: Text(option.label ?? '')))
                    .toList()),
            FormBuilderDropdown<MstLdvNextAction>(
                name: 'actionPlan',
                decoration: InputDecoration(label: 'Tindakan Selanjutnya'.text.make()),
                initialValue: MstLdvNextAction().findByPk(cont.initialValue.value?.actionPlan),
                onChanged: (val) => cont.dataChanged(true),
                valueTransformer: (val) => val?.code,
                items: MstLdvNextAction()
                    .findAll()
                    .map((option) => DropdownMenuItem(value: option, child: Text(option.label ?? '')))
                    .toList()),
            FormBuilderTextField(
                name: 'notes', maxLines: 6, decoration: InputDecoration(label: 'Keterangan'.text.make())),
            // 'Komentar'.remarks.make(),
            // 'Mobile Phone'.phoneNumber.make(),
            FormBuilderTextField(
                name: 'mobPhone1', maxLines: 1, decoration: InputDecoration(label: 'Mobile Phone'.text.make())),
          ].column());
}

class PenerimaanView extends StatelessWidget {
  const PenerimaanView({super.key});

  @override
  Widget build(context) => [
        FormBuilderTextField(
            name: 'receivedAmount',
            valueTransformer: (value) => value == null ? 0 : double.parse(value),
            maxLines: 1,
            decoration: InputDecoration(label: 'Penerimaan'.text.make())),
        FormBuilderTextField(
            name: 'strukNo', maxLines: 1, decoration: InputDecoration(label: 'Kode Struk'.text.make())),
      ].column();
}
