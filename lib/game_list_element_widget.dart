// Flutter imports:
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
import 'spinner_widget.dart';
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
    if (game == null || variant == null) {
      return const SpinnerWidget();
    }
    // TODO(zond): When we have replacement support, this needs more logic.
    if (game.err != null || variant.err != null) {
      return Column(
        children: [
          Text("${game.err}"),
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
                              if (game.private)
                                _MetadataIcon(Icons.lock, l10n.private),
                              if (game.ownerUID != "")
                                _MetadataIcon(Icons.gavel, l10n.hasGameMaster),
                              if (game.disablePrivateChat ||
                                  game.disableGroupChat ||
                                  game.disableConferenceChat)
                                _MetadataIcon(
                                    Icons.phone_locked, l10n.someChatsDisabled),
                            ],
                          ),
                          Tooltip(
                              message: l10n.c_of_p_playersJoined(
                                  "$nMembers", "$nVariantNations"),
                              child: const Icon(Icons.people,
                                  size: metadataIconSize)),
                          Text("$nMembers/$nVariantNations"),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                            "${game["Variant"]}, ${game.combinedPhaseLengthDuration(context)}"),
                      ),
                      Text(game.phaseMeta.desc(context)),
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
