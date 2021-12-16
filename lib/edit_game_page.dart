// Flutter imports:
import 'package:corpulentpangolin/cache.dart';
import 'package:corpulentpangolin/spinner_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'game.dart';
import 'layout.dart';
import 'router.gr.dart';
import 'variant.dart';
import 'edit_game_widget.dart';

class EditGamePage extends StatefulWidget {
  final String gameID;
  final Game? initialData;
  const EditGamePage(
      {Key? key, @PathParam('gameID') required this.gameID, this.initialData})
      : super(key: key);

  @override
  _EditGamePageState createState() => _EditGamePageState();
}

class _EditGamePageState extends State<EditGamePage> {
  final gameCollection = FirebaseFirestore.instance.collection("Game");

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Game?>.value(
      value:
          cacheDocSnapshots(gameCollection.doc(widget.gameID)).map((snapshot) {
        if (!snapshot.exists) {
          return const Game.fromMap(
              {"Error": "EditGamePage Game error: Game doesn't exist!"});
        }
        return Game(snapshot);
      }),
      initialData: widget.initialData,
      builder: (context, _) {
        final game = context.watch<Game?>();
        final appRouter = context.read<AppRouter>();
        final variants = context.watch<Variants?>();
        final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
        final user = context.watch<User?>();
        if (user == null) {
          return const Text("Can't edit game unless logged in!");
        }
        if (game == null) {
          return const SpinnerWidget();
        }
        if (variants?.err != null || game.err != null) {
          return Column(
            children: [
              Text("EditGamePage Variants error: ${variants?.err}"),
              Text("EditGamePage Game error: ${game.err}"),
            ],
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appName),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => appRouter.replace(const HomePageRoute()),
            ),
          ),
          body: SmallPadding(child: EditGameWidget(game: game)),
        );
      },
    );
  }
}
