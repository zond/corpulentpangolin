// Flutter imports:
import 'package:corpulentpangolin/app_user.dart';
import 'package:corpulentpangolin/spinner_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:corpulentpangolin/variant.dart';
import 'game.dart';
import 'router.gr.dart';

@immutable
class GameControlsWidget extends StatelessWidget {
  const GameControlsWidget({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final variant = context.watch<Variant?>();
    final game = context.watch<Game?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final appRouter = context.read<AppRouter>();
    final user = context.watch<User?>();
    final appUser = context.watch<AppUser?>();
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
    final joinable = game.joinable(
        context: context, appUser: appUser, user: user, variant: variant);
    final leavable = game.leavable(context: context, user: user);
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        if (joinable.value && !leavable.value)
          ElevatedButton(
            onPressed: () => game.join(context: context, user: user),
            child: Text(l10n.join),
          ),
        if (!joinable.value && leavable.value)
          ElevatedButton(
            onPressed: () => game.leave(context: context, user: user),
            child: Text(l10n.leave),
          ),
        ElevatedButton(
          onPressed: null,
          child: Text(l10n.share),
        ),
        ElevatedButton(
          onPressed: () => appRouter.push(GamePageRoute(gameID: game.id)),
          child: Text(l10n.view),
        ),
        Tooltip(
          message: user == null
              ? l10n.logInToEnableThisButton
              : (user.uid == game.ownerUID
                  ? ""
                  : l10n.youCantEditGamesYouDontOwn),
          child: ElevatedButton(
            onPressed: user?.uid == game.ownerUID
                ? () => appRouter.push(EditGamePageRoute(gameID: game.id))
                : null,
            child: Text(l10n.edit),
          ),
        ),
      ],
    );
  }
}
