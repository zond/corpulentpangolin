// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:corpulentpangolin/layout.dart';
import 'package:corpulentpangolin/player_widget.dart';
import 'game.dart';
import 'player_widget.dart';
import 'spinner_widget.dart';

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
            _MetadataRow(Icons.map, l10n.gameVariant_Var_(game.variant)),
            if (game.private) _MetadataRow(Icons.lock, l10n.private),
            if (game.ownerUID != "")
              _MetadataRow(Icons.gavel, l10n.hasGameMaster),
            _MetadataRow(Icons.av_timer,
                l10n.phaseDeadline_Date_(game.phaseLengthDuration(context))),
            if (game.nonMovementPhaseLengthMinutes != 0 &&
                game.nonMovementPhaseLengthMinutes != game.phaseLengthMinutes)
              _MetadataRow(
                  Icons.av_timer,
                  l10n.nonMovementPhaseDeadline_Date_(
                      game.nonMovementPhaseLengthDuration(context))),
            _MetadataRow(Icons.cake, l10n.created_Date_(game.createdAt)),
            if (game.isStarted)
              _MetadataRow(Icons.flag, l10n.started_Date_(game.startedAt)),
            if (game.isFinished)
              _MetadataRow(
                  Icons.play_arrow, l10n.finished_Date_(game.finishedAt)),
            _MetadataRow(Icons.sort,
                l10n.nationSelection_Type_(game.nationSelection(context))),
            if (game.minimumReliability != 0)
              _MetadataRow(Icons.timer,
                  l10n.minimumReliability_V_("${game.minimumReliability}")),
            if (game.minimumQuickness != 0)
              _MetadataRow(Icons.timer,
                  l10n.minimumQuickness_V_("${game.minimumQuickness}")),
            if (game.minimumRating != 0)
              _MetadataRow(
                  Icons.star, l10n.minimumRating_V_("${game.minimumRating}")),
            if (game.disableConferenceChat)
              _MetadataRow(Icons.phone_locked, l10n.publicChatDisabled),
            if (game.disableGroupChat)
              _MetadataRow(Icons.phone_locked, l10n.groupChatDisabled),
            if (game.disablePrivateChat)
              _MetadataRow(Icons.phone_locked, l10n.privateChatDisabled),
            if (game.musteringRequired)
              _MetadataRow(Icons.pan_tool, l10n.hasMustering),
            if (game.nmrsBeforeReplaceable > 0)
              _MetadataRow(Icons.content_cut, l10n.hasAutoReplacements),
            if (game.hasGrace) _MetadataRow(Icons.pause, l10n.hasGracePeriods),
            if (game.extensionsPerPlayer > 0 &&
                game.maxExtensionLengthMinutes > 0)
              _MetadataRow(Icons.pause, l10n.hasExtensions),
            if (game.maxExtensionLengthMinutes > 0)
              _MetadataRow(
                  Icons.pause,
                  l10n.votesRequiredForExtension_V_(
                      "${(game.playerRatioForExtraExtensionVote * 100).round()}%")),
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

@immutable
class _MetadataRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetadataRow(this.icon, this.text, {Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return Row(
      children: [
        Icon(icon),
        smallHorizSpace,
        Text(text, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
