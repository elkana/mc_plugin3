import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mc_plugin3/controller/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widget/ldv/ldv.dart';
import 'ldvlist_controller.dart';

class LdvListView extends GetView<LdvListController> {
  const LdvListView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(
        title: 'Ldv List'.text.make(),
        actions: [
          IconButton(onPressed: controller.viewDatabase, icon: const Icon(Icons.storage_rounded)),
          IconButton(onPressed: controller.resetData, icon: const Icon(Icons.restore_page)),
          IconButton(onPressed: AuthController.instance.logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Obx(() => RefreshIndicator(
          onRefresh: controller.refreshData,
          child: controller.loading.isTrue
              ? const CircularProgressIndicator()
              : LdvList(onTapItem: controller.onVisit).scrollVertical(
                  controller: controller.scrollAktif,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())))));
}
