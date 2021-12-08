import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'spinner_widget.dart';
import 'game.dart';

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
                const Padding(padding: EdgeInsets.only(left: 5)),
                const Icon(Icons.map),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Text(l10n.gameVariant(game.variant),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                const Icon(Icons.av_timer),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Text(l10n.phaseDeadline(game.phaseLengthDuration(context)),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                const Icon(Icons.cake),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Text(l10n.created(game.createdAt),
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ],
        )
      ],
    );
  }
}
