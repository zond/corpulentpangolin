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

class SVGWidgetConditional extends StatelessWidget {
  final String source;
  final List<String Function(String)>? mutations;
  const SVGWidgetConditional({
    Key? key,
    required this.source,
    this.mutations,
  }) : super(key: key);
  @override
  Widget build(context) {
    final elementID = "SVG-${_nextID++}";
    final mutatedSource =
        "<div id=\"$elementID\">$source<script>${(mutations ?? []).map((mut) => mut(elementID)).join("\n")}</script></div>";
    ui.platformViewRegistry.registerViewFactory("svg-widget", (int id) {
      final element = html.Element.html(mutatedSource, validator: _Validator());
      element.style.width = "100%";
      element.style.height = "100%";
      return element;
    });
    const view = HtmlElementView(viewType: "svg-widget");
    return view;
  }
}
