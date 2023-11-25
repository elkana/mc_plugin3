import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'viewtable_controller.dart';

class ViewTableBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<ViewTableController>(() => ViewTableController());
}

class ViewTableView extends GetView<ViewTableController> {
  const ViewTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        const SliverAppBar(
            expandedHeight: 160, pinned: true, flexibleSpace: FlexibleSpaceBar(title: Text('View Table'))),
        SliverList(
            delegate: SliverChildListDelegate([
          SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: DataTable(columns: controller.columns, rows: controller.rows))
        ]))
      ]));
}
