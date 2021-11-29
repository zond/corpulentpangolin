import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

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
  const HTMLWidgetConditional({
    Key? key,
    required this.source,
    this.mutations,
  }) : super(key: key);
  @override
  Widget build(context) {
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
