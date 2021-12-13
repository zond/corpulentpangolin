import 'package:corpulentpangolin/layout.dart';
import 'package:corpulentpangolin/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'spinner_widget.dart';
import 'game.dart';
import 'player_widget.dart';

class GameMetadataWidget extends StatelessWidget {
  const GameMetadataWidget({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final game = context.watch<Game?>();
    if (game == null) {
      return const SpinnerWidget();
    }
    if (game.err != null) {
      return Text("Game error: ${game.err}");
    }
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.map),
                smallHorizSpace,
                Text(l10n.gameVariant_Var_(game.variant),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.av_timer),
                smallHorizSpace,
                Text(
                    l10n.phaseDeadline_Date_(game.phaseLengthDuration(context)),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            if (game.nonMovementPhaseLengthMinutes != 0 &&
                game.nonMovementPhaseLengthMinutes != game.phaseLengthMinutes)
              Row(
                children: [
                  const Icon(Icons.av_timer),
                  smallHorizSpace,
                  Text(
                      l10n.nonMovementPhaseDeadline_Date_(
                          game.nonMovementPhaseLengthDuration(context)),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            Row(
              children: [
                const Icon(Icons.cake),
                smallHorizSpace,
                Text(l10n.created_Date_(game.createdAt),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            if (game.isStarted)
              Row(
                children: [
                  const Icon(Icons.cake),
                  smallHorizSpace,
                  Text(l10n.started_Date_(game.startedAt),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            if (game.isFinished)
              Row(
                children: [
                  const Icon(Icons.cake),
                  smallHorizSpace,
                  Text(l10n.finished_Date_(game.finishedAt),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            Row(
              children: [
                const Icon(Icons.sort),
                smallHorizSpace,
                Text(l10n.nationSelection_Type_(game.nationSelection(context)),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            if (game.minimumReliability != 0)
              Row(
                children: [
                  const Icon(Icons.timer),
                  smallHorizSpace,
                  Text(l10n.minimumReliability_V_("${game.minimumReliability}"),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            if (game.minimumQuickness != 0)
              Row(
                children: [
                  const Icon(Icons.timer),
                  smallHorizSpace,
                  Text(l10n.minimumQuickness_V_("${game.minimumQuickness}"),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            if (game.minimumRating != 0)
              Row(
                children: [
                  const Icon(Icons.timer),
                  smallHorizSpace,
                  Text(l10n.minimumRating_V_("${game.minimumRating}"),
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            if (game.players.isNotEmpty)
              Card(
                child: SmallPadding(
                  child: Column(
                    children: [
                      Text(l10n.players,
                          style: Theme.of(context).textTheme.subtitle1),
                      ...game.players.map((p) => PlayerWidget(uid: p)),
                    ],
                  ),
                ),
              )
          ],
        )
      ],
    );
  }
}
