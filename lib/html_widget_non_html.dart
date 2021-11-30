import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';

int _nextID = 0;

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
    final elementID = "HTML-${_nextID++}";
    final mutatedSource = "<div id=\"$elementID\">$source</div>";
    return InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(supportZoom: false)),
        onConsoleMessage: (ctrl, m) => debugPrint("$m"),
        onWebViewCreated: (ctrl) {
          if (callback != null) {
            ctrl.addJavaScriptHandler(
              handlerName: "flutter_cb",
              callback: (s) {
                callback!(json.decode(s.isNotEmpty ? s[0] : {}));
              },
            );
          }
        },
        onLoadStop: (ctrl, uri) {
          if (mutations != null) {
            ctrl.evaluateJavascript(
                source:
                    "window.flutter_cb = (m) => { window.flutter_inappwebview.callHandler('flutter_cb', m); };");
            mutations!.forEach((mut) {
              ctrl.evaluateJavascript(source: mut(elementID));
            });
          }
        },
        initialData: InAppWebViewInitialData(
            data: mutatedSource, mimeType: "text/html"));
  }
}
