import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'game.dart';
import 'spinner_widget.dart';
import 'game_list_element_widget.dart';

class GameListWidget extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> gamesStream;
  const GameListWidget(this.gamesStream, {Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: gamesStream,
      builder: (context, gamesQuerySnapshot) {
        if (gamesQuerySnapshot.hasError) {
          return Text("Error loading games: ${gamesQuerySnapshot.error}");
        } else if (gamesQuerySnapshot.connectionState ==
            ConnectionState.waiting) {
          return const SpinnerWidget();
        }
        final games = gamesQuerySnapshot.data!.docs;
        if (games.isEmpty) {
          return Material(child: ListTile(title: Text(l10n.noGamesFound)));
        }
        return Expanded(
          child: ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, idx) {
              return gameProvider(
                gameID: games[idx].id,
                initialData: Game(games[idx]),
                child: const GameListElementWidget(),
              );
            },
          ),
        );
      },
    );
  }
}
