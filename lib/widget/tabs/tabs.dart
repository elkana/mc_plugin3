import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TabsTop extends StatelessWidget {
  final TabController controller;
  final Alignment? alignTab;
  final List<String> titles;
  final List<Widget> children;
  const TabsTop({
    Key? key,
    required this.controller,
    required this.titles,
    required this.children,
    this.alignTab,
  }) : super(key: key);

  @override
  Widget build(context) => [
        TabBar(
          isScrollable: true,
          tabs: titles
              .map((e) => Badge.count(count: 78, isLabelVisible: false, child: MyTab(icon: Icons.search, title: e)))
              .toList(growable: false),
          controller: controller,
          // padding: EdgeInsets.zero,
          // indicatorPadding: EdgeInsets.zero,
          // labelPadding: const EdgeInsets.all(4),
          // labelColor: Colors.white,
          indicator: const CustomTabIndicator(),
          // indicator: CircleTabIndicator(color: Colors.indigo, radius: 4),
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          // unselectedLabelColor: Colors.indigo.shade100,
          // indicatorColor: Colors.indigo,
          // indicatorWeight: 8,
        ),
        // .material(color: Theme.of(context).primaryColor),
        TabBarView(controller: controller, children: children)
            .box
            // .withDecoration(BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: <Color>[Theme.of(context).primaryColor, Colors.indigo],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter)))
            .make()
            .expand()
      ].column(
          crossAlignment: alignTab == null || alignTab == Alignment.center
              ? null
              : alignTab == Alignment.centerLeft
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end);
}

class MyTab extends StatelessWidget {
  final IconData icon;
  final String title;
  const MyTab({Key? key, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(context) => Tab(
          child: [
        // Icon(
        //   icon,
        //   // color: Colors.indigo,
        // ).marginOnly(right: 10),
        title.text.sm.indigo800.letterSpacing(1).make(),
        // Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1))
      ].row());
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _CirclePainter(color: color, radius: radius);
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(canvas, offset, cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset = offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}

// https://stackoverflow.com/questions/60207392/flutter-how-to-make-custom-rounded-shape-tab-indicator-with-fixed-height
class CustomTabIndicator extends Decoration {
  final double radius;
  final Color color;
  final double indicatorHeight;

  const CustomTabIndicator({
    this.radius = 8,
    this.indicatorHeight = 8,
    this.color = Colors.blue,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) =>
      _CustomPainter(this, onChanged, radius, color, indicatorHeight);
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(canvas, offset, configuration) {
    assert(configuration.size != null);
    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos = offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;
    RRect fullRect = RRect.fromRectAndCorners(
        Rect.fromCenter(center: Offset(xAxisPos, yAxisPos), width: configuration.size!.width, height: indicatorHeight),
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius));
    canvas.drawRRect(fullRect, paint);
  }
}
