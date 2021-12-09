import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'variant.dart';
import 'spinner_widget.dart';
import 'map_widget.dart';

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
      catchError: (context, e) =>
          SVGBundle(map: const [], units: const {}, err: e),
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
