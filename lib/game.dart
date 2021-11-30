import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'phase.dart';
import 'variant.dart';
import 'cache.dart';

@immutable
class Game extends MapView<String, dynamic> {
  const Game(base) : super(base);
  Object? get err {
    if (containsKey("Error")) {
      return this["Error"];
    }
    return null;
  }
}

Widget gameProvider({
  required String gameID,
  required Widget child,
  Stream<DocumentSnapshot>? gameStream,
}) {
  gameStream = gameStream ??
      cacheDocSnapshots(
          FirebaseFirestore.instance.collection("Game").doc(gameID));
  return MultiProvider(
    providers: [
      StreamProvider<Game?>.value(
        value: gameStream.map((snapshot) {
          final res = Game(snapshot.data());
          res["ID"] = snapshot.id;
          return res;
        }),
        catchError: (context, e) => {"Error": "$e"} as Game,
        initialData: null,
      ),
      StreamProvider<Phase?>.value(
        value: cacheQuerySnapshots(FirebaseFirestore.instance
                .collection("Game")
                .doc(gameID)
                .collection("Phase")
                .orderBy("Ordinal", descending: true)
                .limit(1))
            .map((snapshot) {
          if (snapshot.size == 0) {
            return null;
          }
          final res = Phase(snapshot.docs[0].data());
          res["ID"] = snapshot.docs[0].id;
          return res;
        }),
        catchError: (context, e) => {"Error": "$e"} as Phase,
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
          if (variants.err != null) {
            return {"Error": variants.err} as Variant;
          }
          return variants.map[game["Variant"] as String];
        },
      ),
    ],
    child: child,
  );
}
