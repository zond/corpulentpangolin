import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'phase.dart';
import 'variant.dart';

class Game extends MapView<String, dynamic> {
  const Game(base) : super(base);
}

Widget gameProvider({
  required String gameID,
  required Widget child,
  Stream<DocumentSnapshot>? gameStream,
}) {
  gameStream = gameStream ??
      FirebaseFirestore.instance.collection("Game").doc(gameID).snapshots();
  return MultiProvider(
    providers: [
      StreamProvider<Game?>.value(
        value: gameStream.map((snapshot) {
          final res = Game(snapshot.data());
          res["ID"] = snapshot.id;
          return res;
        }),
        initialData: null,
      ),
      StreamProvider<Phase?>.value(
        value: FirebaseFirestore.instance
            .collection("Game")
            .doc(gameID)
            .collection("Phase")
            .orderBy("Ordinal", descending: true)
            .limit(1)
            .snapshots()
            .map((snapshot) {
          if (snapshot.size == 0) {
            return null;
          }
          final res = Phase(snapshot.docs[0].data());
          res["ID"] = snapshot.docs[0].id;
          return res;
        }),
        initialData: null,
      ),
      ProxyProvider<Game?, Variant?>(
        update: (context, game, __) {
          final variants = context.watch<Variants?>();
          if (game == null) {
            return null;
          }
          if (variants == null) {
            return null;
          }
          return variants.map[game["Variant"] as String];
        },
      ),
    ],
    child: child,
  );
}
