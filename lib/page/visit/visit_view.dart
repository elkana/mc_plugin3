import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
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
            builder: (c) => '${OTrnLdvDetail().findByPk(c.contractPk!.ldvNo!, c.contractPk!.contractNo!)}'.text.make())
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
  Widget build(context) => [
        MyFormBuilderDropDown<String>('whoMet', 'Bertemu Dengan',
            items: MstLdvPersonal()
                .findAll
                .map((o) => DropdownMenuItem(value: o.code, child: '${o.description}'.text.make()))
                .toList(growable: false)),
        MyFormBuilderDropDown<String>('delqCode', 'Alasan',
            items: MstLdvDelqReason()
                .findAll
                .map((o) => DropdownMenuItem(value: o.code, child: '${o.description}'.text.make()))
                .toList(growable: false)),
        MyFormBuilderDropDown<String>('classCode', 'Klasifikasi',
            items: MstLdvClassification()
                .findAll
                .map((o) => DropdownMenuItem(value: o.code, child: '${o.label}'.text.make()))
                .toList(growable: false)),
        MyFormBuilderDropDown<String>('actionPlan', 'Tindakan Selanjutnya',
            items: MstLdvNextAction()
                .findAll
                .map((o) => DropdownMenuItem(value: o.code, child: '${o.label}'.text.make()))
                .toList(growable: false)),
        FormBuilderTextField(name: 'notes', maxLines: 6, decoration: InputDecoration(label: 'Keterangan'.text.make())),
        // 'Komentar'.remarks.make(),
        // 'Mobile Phone'.phoneNumber.make(),
        FormBuilderTextField(
            name: 'mobPhone1', maxLines: 1, decoration: InputDecoration(label: 'Mobile Phone'.text.make())),
      ].column();
}

class PenerimaanView extends StatefulWidget {
  final bool enabled;
  const PenerimaanView({super.key, this.enabled = true});

  @override
  State<PenerimaanView> createState() => _PenerimaanViewState();
}

class _PenerimaanViewState extends State<PenerimaanView> with AutomaticKeepAliveClientMixin<PenerimaanView> {
  @override
  Widget build(context) {
    super.build(context);
    return [
      FormBuilderField<num>(
          name: 'receivedAmount',
          builder: (f) => MyTextFormField('Jumlah',
              initialValue: f.value?.toString(),
              onSaved: (newValue) => f.didChange(newValue == null ? null : double.tryParse(newValue)))),
      FormBuilderTextField(
        name: 'strukNo',
        maxLines: 1,
        decoration: InputDecoration(label: 'Kode Struk'.text.make()),
      ),
    ].column();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
