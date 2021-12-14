// Dart imports:
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:universal_html/html.dart' as html;

class _Validator implements html.NodeValidator {
  @override
  bool allowsAttribute(
          html.Element element, String attributeName, String value) =>
      true;
  @override
  bool allowsElement(html.Element element) => true;
}

Map<Key, String> _html = {};

@immutable
class HTMLWidgetConditional extends StatelessWidget {
  final String source;
  final Map<String, Function(String)>? callbacks;
  const HTMLWidgetConditional({
    required Key key,
    required this.source,
    this.callbacks,
  }) : super(key: key);
  @override
  Widget build(context) {
    _html[key!] = source;

    if (callbacks != null) {
      callbacks!.forEach((name, func) {
        setProperty(html.window, name, allowInterop(func));
      });
    }

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory("html-widget-${key.toString()}",
        (int id) {
      final element = html.Element.html(_html[key], validator: _Validator());
      element.style.width = "100%";
      element.style.height = "100%";
      return element;
    });
    return HtmlElementView(viewType: "html-widget-${key.toString()}");
  }
}
