// Flutter imports:
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
import 'spinner_widget.dart';

@immutable
class GameControlsWidget extends StatelessWidget {
  const GameControlsWidget({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final game = context.watch<Game?>();
    final user = context.watch<User?>();
    final appUser = context.watch<AppUser?>();
    final variant = context.watch<Variant?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final appRouter = context.read<AppRouter>();
    if (game == null || variant == null) {
      return const SpinnerWidget();
    }
    if (game.err != null || variant.err != null) {
      return Column(
        children: [
          Text("GameControlsWidget Game error: ${game.err}"),
          Text("GameControlsWidget Variant error: ${variant.err}"),
        ],
      );
    }
    final isBanned = appUser != null &&
        (appUser.bannedUsers.intersection(game.players.toSet()).isNotEmpty ||
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
    // TODO(zond): When we have replacement support, this needs more logic.
    final isJoinable = user != null &&
        !game.players.contains(user.uid) &&
        game.players.length < variant.nations.length;
    return ButtonBar(
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
          onPressed: () => appRouter.push(GamePageRoute(gameID: game.id)),
          child: Text(l10n.view),
        ),
      ],
    );
  }
}
