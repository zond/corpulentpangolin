import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'spinner.dart';
import 'game_list_element.dart';

class GameList extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> gamesStream;
  const GameList(this.gamesStream, {Key? key}) : super(key: key);
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
          return const Spinner();
        }
        final games = gamesQuerySnapshot.data!.docs;
        if (games.isEmpty) {
          return const Material(child: ListTile(title: Text("No games found")));
        }
        return Column(
          children: games.map((game) {
            return GameListElement(gameID: game.id, game: Stream.value(game));
          }).toList(),
        );
      },
    );
  }
}
