import 'package:flutter/material.dart';

const smallSpace = 5.0;

const smallHorizSpace = SizedBox(width: smallSpace);

Widget smallPadding(Widget child) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: child,
  );
}
