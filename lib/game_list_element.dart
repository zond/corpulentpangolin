import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'spinner.dart';
import 'variants.dart';
import 'phase.dart';

class GameListElement extends StatelessWidget {
  final Stream<DocumentSnapshot>? game;
  final String gameID;

  const GameListElement({Key? key, this.game, required this.gameID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final variants = context.watch<Variants?>();
    if (variants == null) {
      return const Spinner();
    }
    final gameStream = game ??
        FirebaseFirestore.instance.collection("Game").doc(gameID).snapshots();
    final lastPhase = FirebaseFirestore.instance
        .collection("Game")
        .doc(gameID)
        .collection("Phase")
        .orderBy("Ordinal", descending: true)
        .limit(1)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: gameStream,
      builder: (context, gameSnapshot) {
        if (gameSnapshot.hasError) {
          return Text("Error loading game: ${gameSnapshot.error}",
              style: const TextStyle(backgroundColor: Colors.white));
        } else if (gameSnapshot.connectionState == ConnectionState.waiting) {
          return const Spinner();
        }
        final game = gameSnapshot.data!.data()! as Map<String, dynamic>;
        final variant = variants.map[game["Variant"]]!;
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: lastPhase,
            builder: (context, lastPhaseSnapshot) {
              if (lastPhaseSnapshot.hasError) {
                return Text("Error loading phase: ${lastPhaseSnapshot.error}",
                    style: const TextStyle(backgroundColor: Colors.white));
              } else if (lastPhaseSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Spinner();
              }
              final lastPhase = lastPhaseSnapshot.data!.docs.isEmpty
                  ? null
                  : lastPhaseSnapshot.data!.docs[0].data();
              final nVariantNations =
                  (variant["Nations"] as List<dynamic>).length;
              final nMembers = (game["Players"] as List<dynamic>).length;
              return Material(
                child: ListTile(
                  leading: Text("$nMembers/$nVariantNations"),
                  title: Text(
                      "${game["Desc"] == "" ? "[unnamed]" : game["Desc"]}"),
                  subtitle: Text(
                      "${game["Variant"]}, ${lastPhase == null ? "" : " ${phaseDesc(lastPhase)}"}"),
                ),
              );
            });
      },
    );
  }
}
