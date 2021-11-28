import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'phase.dart';
import 'svg_widget.dart';
import 'variant.dart';
import 'spinner_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(context) {
    final game = context.watch<Game?>();
    final lastPhase = context.watch<Phase?>();
    final variant = context.watch<Variant?>();
    if (game == null || variant == null || lastPhase == null) {
      return const SpinnerWidget();
    }
    return StreamBuilder<List<int>>(
      stream: variant.mapSVG,
      builder: (context, mapSVG) {
        if (mapSVG.data == null) {
          return const SpinnerWidget();
        }
        return Column(
          children: [
            Text("map ${game["Desc"]}"),
            Expanded(
              child: InteractiveViewer(
                maxScale: 10,
                minScale: 0.1,
                child: SVGWidget(source: String.fromCharCodes(mapSVG.data!)),
              ),
            ),
          ],
        );
      },
    );
  }
}
