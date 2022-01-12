// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'game.dart';
import 'layout.dart';
import 'router.gr.dart';
import 'variant.dart';
import 'edit_game_widget.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final game = Game.fromMap({
    "CreatorUID": FirebaseAuth.instance.currentUser?.uid,
    "OwnerUID": "",
    "InvitationRequired": false,
    "MusteringRequired": true,
    "NationSelection": "random",
    "Desc": "",
    "PhaseLengthMinutes": 1440,
    "NonMovementPhaseLengthMinutes": 0,
    "MinReliability": 0.0,
    "MinQuickness": 0.0,
    "MinRating": 0.0,
    "Private": false,
    "DisablePrivateChat": false,
    "DisableGroupChat": false,
    "DisableConferenceChat": false,
    "Variant": "Classical",
    "Players": [FirebaseAuth.instance.currentUser?.uid],
    "Members": [FirebaseAuth.instance.currentUser?.uid],
    "CategorySortKey": 1000,
    "DontStartBeforeMinuteInDay": 0,
    "DontStartAfterMinuteInDay": 0
  });
  final gameCollection = FirebaseFirestore.instance.collection("Game");

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<AppRouter>();
    final variants = context.watch<Variants?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final user = context.watch<User?>();
    if (user == null) {
      return const Text("Can't create game unless logged in!");
    }
    if (variants != null && variants.err != null) {
      return Text("Variants error: ${variants.err}");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => appRouter.replace(const HomePageRoute()),
        ),
      ),
      body: SmallPadding(
          child: Column(
        children: [
          Text(l10n.createGame, style: Theme.of(context).textTheme.headline5),
          Expanded(
            child: EditGameWidget(game: game),
          ),
        ],
      )),
    );
  }
}
