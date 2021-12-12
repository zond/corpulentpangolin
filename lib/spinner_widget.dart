import 'package:flutter/material.dart';

import 'layout.dart';

class SpinnerWidget extends StatefulWidget {
  const SpinnerWidget({Key? key}) : super(key: key);
  @override
  State<SpinnerWidget> createState() => _SpinnerWidgetState();
}

class _SpinnerWidgetState extends State<SpinnerWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          smallPadding(CircularProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
          )),
        ],
      ),
    );
  }
}
