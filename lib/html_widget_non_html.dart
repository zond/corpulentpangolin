import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

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
    return WebView(
      initialUrl: Uri.dataFromString('''
<script>
  ${callbacks?.keys.map((name) => "window.$name = (m) => { window.${name}_channel.postMessage(m); };").join("\n")}
</script>
$source
''', mimeType: "text/html").toString(),
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: Set.from(callbacks?.keys.map((name) =>
              JavascriptChannel(
                  name: "${name}_channel",
                  onMessageReceived: (m) =>
                      callbacks![name]!(json.decode(m.message)))) ??
          []),
    );
  }
}
