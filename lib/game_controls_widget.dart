// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corpulentpangolin/spinner_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:corpulentpangolin/variant.dart';
import 'app_user.dart';
import 'game.dart';
import 'router.gr.dart';
import 'toast.dart';

@immutable
class GameControlsWidget extends StatelessWidget {
  const GameControlsWidget({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final user = context.watch<User?>();
    final appUser = context.watch<AppUser?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final appRouter = context.read<AppRouter>();
    final variant = context.watch<Variant?>();
    final game = context.watch<Game?>();
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
    List<Widget> buttons = [];
    if (user != null) {
      if (game.players.contains(user.uid)) {
        buttons.add(Tooltip(
            message: game.started ? l10n.youCantLeaveStartedGames : "",
            child: ElevatedButton(
              onPressed: game.started
                  ? null
                  : () {
                      FirebaseFirestore.instance
                          .collection("Game")
                          .doc(game.id)
                          .update({
                            "Players": game.players
                                .where((id) => id != user.uid)
                                .toList(),
                          })
                          .then((_) => toast(context, l10n.leftGame))
                          .catchError((err) {
                            debugPrint("Failed saving game: $err");
                            toast(context, l10n.failedSavingGame_Err_(err));
                          });
                    },
              child: Text(l10n.leave),
            )));
      } else {
        final isBanned = appUser != null &&
            (appUser.bannedUsers
                    .intersection(game.players.toSet())
                    .isNotEmpty ||
                appUser.bannedByUsers
                    .intersection(game.players.toSet())
                    .isNotEmpty);
        final matchesRequirements = (game.minimumReliability == 0 &&
                game.minimumQuickness == 0 &&
                game.minimumRating == 0) ||
            (appUser != null &&
                appUser.reliability >= game.minimumReliability &&
                appUser.quickness >= game.minimumQuickness &&
                appUser.rating >= game.minimumRating);
        final invitationOK = !game.invitationRequired || game.invitedPlayers.contains(user.uid);
        // TODO(zond): When we have replacement support, this needs more logic.
        final isJoinable = !isBanned &&
            invitationOK &&
            matchesRequirements &&
            !game.players.contains(user.uid) &&
            game.players.length <
                (variant == null ? 0 : variant.nations.length);
        List<String> joinTooltips = [
          if (game.players.contains(user.uid)) l10n.youAreAlreadyInGame,
          if (game.players.length >=
              (variant == null ? -1 : variant.nations.length))
            l10n.gameFullNoReplacements,
          if (isBanned) l10n.someoneYouBanned,
          if (!matchesRequirements) l10n.youDonMatchRequirements,
        ];
        buttons.add(Tooltip(
          message: joinTooltips.join("\n"),
          child: ElevatedButton(
            onPressed: isJoinable
                ? () {
                    FirebaseFirestore.instance
                        .collection("Game")
                        .doc(game.id)
                        .update({
                          "Players": [...game.players, user.uid],
                        })
                        .then((_) => toast(context, l10n.gameJoined))
                        .catchError((err) {
                          debugPrint("Failed saving game: $err");
                          toast(context, l10n.failedSavingGame_Err_(err));
                        });
                  }
                : null,
            child: Text(l10n.join),
          ),
        ));
      }
    } else {
      buttons.add(Tooltip(
          message: l10n.youAreNotLoggedIn,
          child: ElevatedButton(
            onPressed: null,
            child: Text(l10n.join),
          )));
    }
    buttons.add(ElevatedButton(
      onPressed: null,
      child: Text(l10n.share),
    ));
    buttons.add(ElevatedButton(
      onPressed: () => appRouter.push(GamePageRoute(gameID: game.id)),
      child: Text(l10n.view),
    ));
    buttons.add(Tooltip(
      message:
          user?.uid == game.ownerUID ? "" : l10n.youCantEditGamesYouDontOwn,
      child: ElevatedButton(
        onPressed: user?.uid == game.ownerUID
            ? () {
                appRouter.push(EditGamePageRoute(gameID: game.id));
              }
            : null,
        child: Text(l10n.edit),
      ),
    ));
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: buttons,
    );
  }
}
