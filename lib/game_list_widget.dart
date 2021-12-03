import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'game.dart';
import 'spinner_widget.dart';
import 'game_list_element_widget.dart';

class GameListWidget extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> gamesStream;
  const GameListWidget(this.gamesStream, {Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: gamesStream,
      builder: (context, gamesQuerySnapshot) {
        if (gamesQuerySnapshot.hasError) {
          return Text("Error loading games: ${gamesQuerySnapshot.error}",
              style: const TextStyle(backgroundColor: Colors.white));
        } else if (gamesQuerySnapshot.connectionState ==
            ConnectionState.waiting) {
          return const SpinnerWidget();
        }
        final games = gamesQuerySnapshot.data!.docs;
        if (games.isEmpty) {
          return const Material(child: ListTile(title: Text("No games found")));
        }
        return Column(
          children: games.map((game) {
            return gameProvider(
              gameID: game.id,
              initialData: Game(game.data() as Map<String, dynamic>),
              child: const GameListElementWidget(),
            );
          }).toList(),
        );
      },
    );
  }
}
