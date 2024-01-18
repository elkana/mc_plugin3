import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/auth_controller.dart';
import 'package:mc_plugin3/page/visit/visit_controller.dart';
import 'package:mc_plugin3/widget/common.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/customs.dart';
import '../../widget/ldv/ldv.dart';
import 'ldvlist_controller.dart';

class LdvListView extends GetView<LdvListController> {
  const LdvListView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: 'Ldv List'.text.make(),
          actions: [
            TextButton(onPressed: clientLogic?.sync, child: 'Sync DB'.text.make()),
            IconButton(onPressed: controller.viewDatabase, icon: const Icon(Icons.storage_rounded)),
            IconButton(onPressed: controller.resetData, icon: const Icon(Icons.restore_page)),
            IconButton(onPressed: AuthController.instance.logout, icon: const Icon(Icons.logout)),
            controller.loading.isTrue
                ? const CircularProgressIndicator()
                : IconButton(onPressed: controller.closeBatch, icon: 'CB'.text.bold.make()),
          ],
        ),
        body: RefreshIndicator(
            onRefresh: controller.refreshData,
            child: [
              LdvHeader(
                  onRender: (o, i) => [
                        '$o'.text.make(),
                        '${i ?? 'inbound header is not found'}'.text.make(),
                      ].column()).card.make(),
              LdvList(onTapItem: (val) => VisitController.show(val.pk!.ldvNo!, val.pk!.contractNo!)!)
                  .scrollV(controller: controller.scrollAktif),
            ].column()),
      );
}
