import 'package:flutter/material.dart';

void toast(BuildContext ctx, String msg) {
  ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(msg),
  ));
}
