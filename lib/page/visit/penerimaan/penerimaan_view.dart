import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../widget/common.dart';

class PenerimaanView extends StatefulWidget {
  final bool enabled;
  const PenerimaanView({super.key, this.enabled = true});

  @override
  State<PenerimaanView> createState() => _PenerimaanViewState();
}

class _PenerimaanViewState extends State<PenerimaanView> with AutomaticKeepAliveClientMixin<PenerimaanView> {
  @override
  Widget build(context) {
    // mandatory
    super.build(context);
    return [
      FormBuilderField<num>(
          name: 'receivedAmount',
          builder: (f) => MyTextFormField('Jumlah',
              initialValue: f.value?.toString(),
              onSaved: (newValue) => f.didChange(newValue == null ? null : double.tryParse(newValue)))),
      FormBuilderTextField(name: 'strukNo', maxLines: 1, decoration: InputDecoration(label: 'Kode Struk'.text.make())),
    ].column();
  }

  @override
  bool get wantKeepAlive => true;
}
