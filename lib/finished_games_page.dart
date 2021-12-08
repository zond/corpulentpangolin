import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'cache.dart';
import 'game_list_widget.dart';
import 'main_app_bar.dart';
import 'main_drawer.dart';
import 'with_background.dart';

class FinishedGamesPage extends StatelessWidget {
  const FinishedGamesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: mainAppBar(context),
      body: withBackground(
        Column(children: [
          Material(
            child: ListTile(
              title: Text(
                l10n.finishedGames,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
              .collection("Game")
              .where("Private", isEqualTo: false)
              .where("Finished", isEqualTo: true)
              .orderBy("TimeSortKey"))),
        ]),
      ),
    );
  }
}
