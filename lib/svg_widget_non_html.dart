import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
    return InAppWebView(
        initialData:
            InAppWebViewInitialData(data: source, mimeType: "image/svg+xml"));
  }
}
