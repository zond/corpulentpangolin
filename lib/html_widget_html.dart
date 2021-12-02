import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'dart:convert';

int _nextKey = 0;

class _Validator implements html.NodeValidator {
  @override
  bool allowsAttribute(
          html.Element element, String attributeName, String value) =>
      true;
  @override
  bool allowsElement(html.Element element) => true;
}

Map<Key, String> _html = {};

class HTMLWidgetConditional extends StatelessWidget {
  final String source;
  final Map<String, Function(Map<String, dynamic>)>? callbacks;
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
        setProperty(html.window, name,
            allowInterop((String s) => func(json.decode(s))));
      });
    }
    ui.platformViewRegistry.registerViewFactory("html-widget-${key.toString()}",
        (int id) {
      final element = html.Element.html(_html[key], validator: _Validator());
      element.style.width = "100%";
      element.style.height = "100%";
      return element;
    });
    return HtmlElementView(
        key: Key("${_nextKey++}"), viewType: "html-widget-${key.toString()}");
  }
}
