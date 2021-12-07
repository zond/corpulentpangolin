import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'game.dart';
import 'variant.dart';
import 'spinner_widget.dart';
import 'phase.dart';
import 'router.gr.dart';

class GameListElementWidget extends StatefulWidget {
  const GameListElementWidget({Key? key}) : super(key: key);

  @override
  State<GameListElementWidget> createState() => _GameListElementWidgetState();
}

class _GameListElementWidgetState extends State<GameListElementWidget> {
  var isExpanded = false;
  @override
  Widget build(context) {
    final appRouter = context.read<AppRouter>();
    final game = context.watch<Game?>();
    final lastPhase = context.watch<Phase?>();
    final variant = context.watch<Variant?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (game == null || variant == null) {
      return const SpinnerWidget();
    }
    if (game.err != null ||
        (lastPhase != null && lastPhase.err != null) ||
        variant.err != null) {
      return Column(
        children: [
          Text("${game.err}"),
          if (lastPhase != null) Text("${lastPhase.err}"),
          Text("${variant.err}"),
        ],
      );
    }
    final nVariantNations = (variant["Nations"] as List<dynamic>).length;
    final nMembers = (game["Players"] as List<dynamic>).length;
    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  onTap: () => appRouter.push(GamePageRoute(gameID: game.id)),
                  title: Row(
                    children: [
                      Expanded(
                          child: Text(
                              "${game["Desc"] == "" ? "[${l10n.unnamed}]" : game["Desc"]}")),
                      game.started
                          ? const Text("<1h")
                          : Row(
                              children: [
                                const Icon(Icons.people),
                                Text("$nMembers/$nVariantNations"),
                              ],
                            ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text("${game["Variant"]}"),
                      ),
                      Text(lastPhase == null
                          ? "(${l10n.loading})"
                          : " ${lastPhase.desc(context)}"),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () => setState(() {
                  isExpanded = !isExpanded;
                }),
              ),
            ],
          ),
          if (isExpanded)
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text(
                      "expanded body with view, join, invite, metadata, and current players"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
