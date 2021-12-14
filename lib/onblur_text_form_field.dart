import 'dart:async';

import 'package:flutter/material.dart';

@immutable
class OnBlurTextFormField extends StatefulWidget {
  final String initialValue;
  final Future<void> Function(String, Function(String)) onBlur;
  final String label;
  const OnBlurTextFormField(
      {Key? key,
      required this.label,
      required this.initialValue,
      required this.onBlur})
      : super(key: key);
  @override
  State<OnBlurTextFormField> createState() => _OnBlurTextFormFieldState();
}

class _OnBlurTextFormFieldState extends State<OnBlurTextFormField> {
  String currentValue = "";
  String savedValue = "";
  late Future<void> Function(String, Function(String)) onBlur;
  late ScaffoldMessengerState messengerState;
  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
    savedValue = currentValue;
    onBlur = widget.onBlur;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    messengerState = ScaffoldMessenger.of(context);
  }

  void _toast(String message) {
    messengerState.hideCurrentSnackBar();
    messengerState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void dispose() {
    if (savedValue != currentValue) {
      onBlur(currentValue, _toast).then((_) {
        savedValue = currentValue;
      });
    }
    super.dispose();
  }

  @override
  Widget build(context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus && savedValue != currentValue) {
          onBlur(currentValue, _toast).then((_) {
            savedValue = currentValue;
          });
        }
      },
      child: TextFormField(
        initialValue: currentValue,
        decoration: InputDecoration(
          labelText: widget.label,
        ),
        onChanged: (newValue) {
          setState(() {
            currentValue = newValue;
          });
        },
      ),
    );
  }
}
