// Flutter imports:
import 'package:corpulentpangolin/spinner_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:corpulentpangolin/game_controls_widget.dart';
import 'game.dart';
import 'game_metadata_widget.dart';
import 'layout.dart';
import 'router.gr.dart';
import 'variant.dart';

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
    final variant = context.watch<Variant?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (game == null) {
      return const SpinnerWidget();
    }
    if (variant?.err != null || game.err != null) {
      return Column(
        children: [
          Text("Variant error: ${variant?.err}"),
          Text("Game error: ${game.err}"),
        ],
      );
    }
    final nVariantNations =
        variant == null ? "?" : variant.nations.length.toString();
    final nMembers = game.players.length;
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
                          child: Text(game.desc == ""
                              ? "[${l10n.unnamed}]"
                              : game.desc)),
                      Row(
                        children: [
                          Row(
                            children: [
                              if (game.minimumReliability > 0 ||
                                  game.minimumQuickness > 0)
                                _MetadataIcon(Icons.timer,
                                    l10n.hasEitherMinRelOrMinQuick),
                              if (game.minimumRating > 0)
                                _MetadataIcon(
                                    Icons.star, l10n.hasMinimumRating),
                              if (game.musteringRequired)
                                _MetadataIcon(
                                    Icons.pan_tool, l10n.hasMustering),
                              if (game.nmrsBeforeReplaceable > 0)
                                _MetadataIcon(Icons.content_cut,
                                    l10n.hasAutoReplacements),
                              if (game.hasGrace || game.hasExtensions)
                                _MetadataIcon(Icons.pause, l10n.hasGraceOrExt),
                              if (game.hasLimitedStartTime)
                                _MetadataIcon(
                                    Icons.timer_off,
                                    l10n.onlyStartTheGameBetween_F_and_T(
                                        game.dontStartBefore.format(context),
                                        game.dontStartAfter.format(context))),
                              if (game.private)
                                _MetadataIcon(Icons.lock, l10n.private),
                              if (game.ownerUID != "")
                                _MetadataIcon(Icons.gavel, l10n.hasGameMaster),
                              if (game.invitationRequired)
                                _MetadataIcon(Icons.lock_open,
                                    l10n.onlyPlayersAssignedByGM),
                              if (game.disablePrivateChat ||
                                  game.disableGroupChat ||
                                  game.disableConferenceChat)
                                _MetadataIcon(
                                    Icons.phone_locked, l10n.someChatsDisabled),
                            ],
                          ),
                          Tooltip(
                              message: l10n.c_of_p_playersJoined(
                                  "$nMembers", nVariantNations),
                              child: Row(
                                children: [
                                  const Icon(Icons.people,
                                      size: metadataIconSize),
                                  Text("$nMembers/$nVariantNations"),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Tooltip(
                              message: l10n.variant,
                              child: Text(game["Variant"]),
                            ),
                            const Text(", "),
                            game.combinedPhaseLengthDuration(context,
                                short: false),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: l10n.currentPhase,
                        child: Text(game.phaseMeta.desc(context)),
                      ),
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
                  children: const [
                    GameControlsWidget(),
                    GameMetadataWidget(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

@immutable
class _MetadataIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  const _MetadataIcon(this.icon, this.tooltip, {Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return Tooltip(
      message: tooltip,
      child: Icon(icon, size: metadataIconSize),
    );
  }
}
