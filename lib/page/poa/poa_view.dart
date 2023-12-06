import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'poa_controller.dart';

class PoaView extends GetView<PoaController> {
  const PoaView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: 'Photo On Arrival'.text.make()),
      body: [
        '${controller.contract}'.text.make(),
        OutlinedButton.icon(
            onPressed: controller.takePhoto, icon: const Icon(Icons.camera), label: 'Ambil Foto'.text.make()),
      ].column());
}
