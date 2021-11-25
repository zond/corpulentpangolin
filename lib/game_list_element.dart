import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'spinner.dart';

class GameListElement extends StatelessWidget {
  final String gameID;

  const GameListElement(this.gameID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game =
        FirebaseFirestore.instance.collection("Game").doc(gameID).snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: game,
        builder: (context, gameSnapshot) {
          if (gameSnapshot.hasError) {
            return Text("Error loading game: ${gameSnapshot.error}",
                style: const TextStyle(backgroundColor: Colors.white));
          } else if (gameSnapshot.connectionState == ConnectionState.waiting) {
            return const Spinner();
          } else {
            final game = gameSnapshot.data!.data() as Map<String, dynamic>;
            final variant = FirebaseFirestore.instance
                .collection("Variant")
                .doc(game["Variant"].toString())
                .snapshots();
            return StreamBuilder<DocumentSnapshot>(
              stream: variant,
              builder: (context, variantSnapshot) {
                if (variantSnapshot.hasError) {
                  return Text("Error loading variant: ${variantSnapshot.error}",
                      style: const TextStyle(backgroundColor: Colors.white));
                } else if (variantSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Spinner();
                } else {
                  final variant =
                      variantSnapshot.data!.data() as Map<String, dynamic>;
                  final nVariantNations =
                      (variant["Nations"] as List<dynamic>).length;
                  final nMembers = (game["Players"] as List<dynamic>).length;
                  return Material(
                    child: ListTile(
                      leading: Text("$nMembers/$nVariantNations"),
                      title: Text(
                          "${game["Variant"]} ${game["Desc"] == "" ? "unnamed" : game["Desc"]}"),
                    ),
                  );
                }
              },
            );
          }
        });
  }
}
