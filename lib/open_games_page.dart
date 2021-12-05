import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'cache.dart';
import 'game_list_widget.dart';
import 'main_app_bar.dart';
import 'main_drawer.dart';
import 'with_background.dart';

class OpenGamesPage extends StatelessWidget {
  const OpenGamesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final l10n = context.read<AppLocalizations>();
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: mainAppBar(context),
      body: withBackground(
        ListView(children: [
          Material(
            child: ListTile(
              title: Text(l10n.openGames,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
              .collection("Game")
              .where('Private', isEqualTo: false))),
        ]),
      ),
    );
  }
}
