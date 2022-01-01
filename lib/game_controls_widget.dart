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
    final editable = game.editable(context: context, user: user);
    return Wrap(
      spacing: 2.0,
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
        if (!joinable.value && !leavable.value)
          Tooltip(
            message: joinable.reasons.join("\n"),
            child: ElevatedButton(
              onPressed: null,
              child: Text(l10n.join),
            ),
          ),
        ElevatedButton(
          onPressed: null,
          child: Text(l10n.share),
        ),
        ElevatedButton(
          onPressed: () => appRouter.push(GamePageRoute(gameID: game.id)),
          child: Text(l10n.view),
        ),
        if (game.canMuster(user))
          ElevatedButton(
            onPressed: null,
            child: Text(l10n.readyToStart),
          ),
        Tooltip(
          message: editable.reasons.join("\n"),
          child: ElevatedButton(
            onPressed: editable.value
                ? () => appRouter.push(EditGamePageRoute(gameID: game.id))
                : null,
            child: Text(l10n.edit),
          ),
        ),
      ],
    );
  }
}
