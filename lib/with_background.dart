import 'package:flutter/material.dart';

Widget withBackground(Widget widget) {
  return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/diplicity_background.jpg"),
            fit: BoxFit.cover),
      ),
      child: widget);
}
