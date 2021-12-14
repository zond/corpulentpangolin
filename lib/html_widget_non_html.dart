// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:webview_flutter/webview_flutter.dart';

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
    return WebView(
      onWebViewCreated: (controller) {
        controller.loadHtmlString('''
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
  <body>
    <script>
      ${callbacks?.keys.map((name) => "window.$name = (m) => { window.${name}_channel.postMessage(m); };").join("\n")}
    </script>
    $source
  </body>
</html>
''');
      },
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: Set.from(callbacks?.keys.map((name) =>
              JavascriptChannel(
                  name: "${name}_channel",
                  onMessageReceived: (m) => callbacks![name]!(m.message))) ??
          []),
    );
  }
}
