import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'spinner.dart';

class GameList extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
  const GameList(this.snapshot, {Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return StreamBuilder<QuerySnapshot>(
      stream: snapshot,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error loading games: ${snapshot.error}",
              style: const TextStyle(backgroundColor: Colors.white));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Spinner();
        } else {
          return Column(
            children: snapshot.data!.docs.map((game) {
              return ListTile(
                title: Text("${game.data()}"),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
