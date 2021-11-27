import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

class SVGWidgetConditional extends StatelessWidget {
  final String source;

  const SVGWidgetConditional({Key? key, required this.source})
      : super(key: key);

  @override
  Widget build(context) {
    ui.platformViewRegistry.registerViewFactory("xx", (int id) {
      final element = html.Element.html(source,
          validator: html.NodeValidatorBuilder()..allowSvg());
      element.style.width = "100%";
      element.style.height = "100%";
      return element;
    });
    return const HtmlElementView(viewType: "xx");
  }
}
