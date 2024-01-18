import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/page/visit/visit_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controller/auth_controller.dart';
import '../../../model/masters.dart';
import '../../../util/photo_util.dart';
import '../../../widget/common.dart';
import '../../../widget/fotoframe/fotoframe.dart';

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
        // album photo
        GetBuilder<VisitController>(
            builder: (c) => PhotoUtil.collateralsGroup
                .map((f) => PhotoFrame(
                        ignore: !c.fotoList.any((e) => e.photoId == f.fileKey),
                        label: f.photoLabel,
                        // urlOrFile: _getFotoUrl(f, c.contractPk!.ldvNo!, c.contractPk!.contractNo!),
                        urlOrFile: c.imageUri == null
                            ? null
                            : PhotoUtil.getLink(c.imageUri!, c.contractPk!.ldvNo, f.fileKey,
                                orElseUseBlobPath: c.fotoList
                                    .firstWhereOrNull((p) =>
                                        p.photoId == f.fileKey &&
                                        p.userId == AuthController.instance.loggedUserId &&
                                        p.sourceId == c.contractPk!.ldvNo)
                                    // p.sourceId == '${ldvNo}_${widget.data.collateralNo}')
                                    ?.blobPath),
                        emptyThumbnail: Icon(f.icon),
                        onPickPhoto: (file) async {
                          var foto = await PhotoUtil.xFileToPhoto(
                              file, f, '${c.contractPk!.ldvNo}', c.contractPk!.contractNo!);
                          // file, f, '${widget.data.sktNo}_${widget.data.collateralNo}', widget.contractNo);
                          // if (widget.onChangeFoto != null) {
                          // widget.onChangeFoto!(foto);
                          // setState(() {});
                          // }

                          int idx =
                              c.fotoList.indexWhere((p) => p.sourceId == foto.sourceId && p.photoId == foto.photoId);
                          if (idx < 0) {
                            c.fotoList.add(foto);
                          } else {
                            c.fotoList[idx] = foto;
                          }
                          c.update();
                        },
                        disable: !c.formEnabled)
                    .wh(120, 180)
                    .card
                    .make())
                .toList()
                .row()
                .scrollHorizontal()),
      ].column();
}
