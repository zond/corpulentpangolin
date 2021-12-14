// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'conditional_rebuild.dart';

import 'html_widget_non_html.dart'
    if (dart.library.html) 'html_widget_html.dart';

class HTMLWidget extends StatelessWidget {
  final String source;
  final Map<String, Function(String)>? callbacks;
  const HTMLWidget({required Key key, required this.source, this.callbacks})
      : super(key: key);
  @override
  Widget build(context) {
    return ConditionalRebuild(
      condition: (_, o, n) =>
          o.source != n.source || o.callbacks != n.callbacks || n.key != o.key,
      child: HTMLWidgetConditional(
        key: key!,
        source: source,
        callbacks: callbacks,
      ),
    );
  }
}
