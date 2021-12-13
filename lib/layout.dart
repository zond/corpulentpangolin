import 'package:flutter/material.dart';

const smallSpace = 5.0;

const avatarIconWidth = 24.0;

const smallHorizSpace = SizedBox(width: smallSpace);

const smallVertSpace = SizedBox(height: smallSpace);

@immutable
class SmallPadding extends StatelessWidget {
  final Widget child;
  const SmallPadding({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: child,
    );
  }
}
