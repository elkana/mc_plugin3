import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../model/masters.dart';
import '../../../widget/common.dart';

class KronologiView extends StatelessWidget {
  const KronologiView({super.key});

  @override
  Widget build(context) => [
        'Bertemu Dengan'.dropDown('whoMet', MstLdvPersonal().findAll, (v) => v.description, (v) => v.code),
        'Alasan'.dropDown('delqCode', MstLdvDelqReason().findAll, (v) => v.description, (v) => v.code),
        'Klasifikasi'.dropDown('classCode', MstLdvClassification().findAll, (v) => v.label, (v) => v.code),
        'Tindakan Selanjutnya'.dropDown('actionPlan', MstLdvNextAction().findAll, (v) => v.label, (v) => v.code),
        'Keterangan'.textField('notes', maxLines: 6),
        'Mobile Phone'.textField('mobPhone1'),
        // 'Komentar'.remarks.make(),
        // 'Mobile Phone'.phoneNumber.make(),
      ].column();
}
