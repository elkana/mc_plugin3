import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mc_plugin3/page/visit/visit_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../model/masters.dart';
import '../../../util/photo_util.dart';
import '../../../widget/common.dart';
import '../../../widget/fotoframe/fotoframe.dart';

class KronologiView extends StatelessWidget {
  const KronologiView({super.key});

  @override
  Widget build(context) => [
        'Bertemu Dengan'.dd('whoMet', MstLdvPersonal().findAll, (v) => v.description, (v) => v.code),
        'Alasan'.dd('delqCode', MstLdvDelqReason().findAll, (v) => v.description, (v) => v.code),
        'Klasifikasi'.dd('classCode', MstLdvClassification().findAll, (v) => v.label, (v) => v.code),
        'Tindakan Selanjutnya'.dd('actionPlan', MstLdvNextAction().findAll, (v) => v.label, (v) => v.code),
        'Keterangan'.tf('notes', maxLines: 6),
        'Mobile Phone'.tf('mobPhone1'),
        // album photo
        GetBuilder<VisitController>(
            builder: (c) => PhotoUtil.groupLdvContract
                .map((f) => PhotoFrame(
                        urlOrFile: c.getFotoUrl(f),
                        onPickPhoto: (file) => c.addFoto(file, f),
                        label: f.photoLabel,
                        emptyThumbnail: Icon(f.icon),
                        disable: c.initialValue.value != null)
                    .wh(120, 180)
                    .card
                    .make())
                .toList()
                .row()
                .scrollHorizontal()),
      ].column();
}
