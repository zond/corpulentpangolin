import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'game.dart';
import 'variant.dart';
import 'spinner_widget.dart';
import 'phase.dart';
import 'router.gr.dart';
import 'game_metadata_widget.dart';
import 'layout.dart';

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
    final user = context.watch<User?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (game == null || variant == null) {
      return const SpinnerWidget();
    }
    // TODO(zond): When we have replacement support, this needs more logic.
    final isJoinable = user != null &&
        !game.players.contains(user.uid) &&
        game.players.length < variant.nations.length;
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
              child: SmallPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: isJoinable
                              ? () {
                                  debugPrint("join!");
                                }
                              : null,
                          child: Text(l10n.join),
                        ),
                        ElevatedButton(
                          onPressed: null,
                          child: Text(l10n.invite),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              appRouter.push(GamePageRoute(gameID: game.id)),
                          child: Text(l10n.view),
                        ),
                      ],
                    ),
                    const GameMetadataWidget(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
