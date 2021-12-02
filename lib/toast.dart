import 'package:flutter/material.dart';

void toast(BuildContext ctx, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
  );
  ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}
