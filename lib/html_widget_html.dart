import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'dart:convert';

int _nextID = 0;

class _Validator implements html.NodeValidator {
  @override
  bool allowsAttribute(
          html.Element element, String attributeName, String value) =>
      true;
  @override
  bool allowsElement(html.Element element) => true;
}

class HTMLWidgetConditional extends StatelessWidget {
  final String source;
  final List<String Function(String)>? mutations;
  final Function(Map<String, dynamic>)? callback;
  const HTMLWidgetConditional({
    Key? key,
    required this.source,
    this.mutations,
    this.callback,
  }) : super(key: key);
  @override
  Widget build(context) {
    if (callback != null) {
      setProperty(html.window, "flutter_cb",
          allowInterop((String s) => callback!(json.decode(s))));
    }

    ui.platformViewRegistry.registerViewFactory("html-widget", (int id) {
      final elementID = "HTML-${_nextID++}";
      final mutatedSource =
          "<div id=\"$elementID\">$source<script>${(mutations ?? []).map((mut) => mut(elementID)).join("\n")}</script></div>";
      final element = html.Element.html(mutatedSource, validator: _Validator());
      element.style.width = "100%";
      element.style.height = "100%";
      return element;
    });
    return const HtmlElementView(viewType: "html-widget");
  }
}
