// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'game.dart';
import 'map_widget.dart';
import 'spinner_widget.dart';
import 'variant.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final variant = context.watch<Variant?>();
    final game = context.watch<Game?>();
    if (variant == null || game == null) {
      return const SpinnerWidget();
    }
    if (variant.err != null || game.err != null) {
      return Column(
        children: [
          Text("Variant error: ${variant.err}"),
          Text("Game error: ${game.err}"),
        ],
      );
    }
    return StreamProvider.value(
      value: variant.svgs,
      catchError: (context, e) {
        debugPrint("MapPage SVGBundle: $e");
        SVGBundle(map: const [], units: const {}, err: e);
      },
      initialData: null,
      child: Column(
        children: [
          Text("map ${game["Desc"]}"),
          Expanded(
            child: MapWidget(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          ),
        ],
      ),
    );
  }
}
