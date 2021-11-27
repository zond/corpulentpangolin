import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'variant.dart';
import 'spinner_widget.dart';
import 'phase.dart';
import 'router.gr.dart';

class GameListElementWidget extends StatelessWidget {
  const GameListElementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<AppRouter>();
    final game = context.watch<Game?>();
    final lastPhase = context.watch<Phase?>();
    final variant = context.watch<Variant?>();
    if (game == null || variant == null) {
      return const SpinnerWidget();
    }
    final nVariantNations = (variant["Nations"] as List<dynamic>).length;
    final nMembers = (game["Players"] as List<dynamic>).length;
    return Material(
      child: ListTile(
        onTap: () => appRouter.pushNamed("/Game/${game["ID"]}/Map"),
        leading: Text("$nMembers/$nVariantNations"),
        title: Text("${game["Desc"] == "" ? "[unnamed]" : game["Desc"]}"),
        subtitle: Text(
            "${game["Variant"]}, ${lastPhase == null ? "" : " ${lastPhase.desc()}"}"),
      ),
    );
  }
}
