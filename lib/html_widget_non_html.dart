import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

int _nextID = 0;

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
    final elementID = "HTML-${_nextID++}";
    final mutatedSource =
        "<div id=\"$elementID\">$source<script>${(mutations ?? []).map((mut) => mut(elementID)).join("\n")}</script></div>";
    return InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(supportZoom: false)),
        onWebViewCreated: (ctrl) {
          ctrl.addJavaScriptHandler(
              handlerName: "flutter_cb",
              callback: (msg) {
                debugPrint("$msg");
              });
        },
        initialData: InAppWebViewInitialData(
            data: mutatedSource, mimeType: "text/html"));
  }
}
