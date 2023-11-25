import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'developer_controller.dart';

class DeveloperBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<DeveloperController>(() => DeveloperController());
}

class DeveloperView extends GetView<DeveloperController> {
  const DeveloperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(title: 'Developer Screen'.text.make()
                // background: Image.asset(
                //   '022.jpg', // <===   Add your own image to assets or use a .network image instead.
                //   fit: BoxFit.cover,
                // ),
                ),
            actions: [IconButton(onPressed: () => controller.refreshList(), icon: const Icon(Icons.refresh))]),
        SliverList(
            delegate: SliverChildListDelegate([
          Obx(() => controller.loading.isTrue
              ? const CircularProgressIndicator().centered()
              : DataTable(columns: const [
                  DataColumn(label: Text('Key')),
                  DataColumn(label: Text('Value')),
                ], rows: controller.rows.value))
        ]))
      ]));
}
