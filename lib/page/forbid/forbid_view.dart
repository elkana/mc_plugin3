import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ForbidView extends StatelessWidget {
  const ForbidView({Key? key}) : super(key: key);

  @override
  Widget build(context) => Scaffold(
      backgroundColor: Colors.indigo,
      body: 'Sorry, This app exceeds life limit.\n\nPlease get latest version.'.text.white.makeCentered());
}
