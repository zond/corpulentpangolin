import 'dart:async';

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
  Game? initialData,
}) {
  final lastPhaseStreamController = StreamController<Phase?>();
  var newestPhaseOrdinal = -1;
  cacheQuerySnapshots(FirebaseFirestore.instance
          .collection("Game")
          .doc(gameID)
          .collection("Phase")
          .orderBy("Ordinal", descending: true)
          .limit(1))
      .forEach((phaseQuerySnapshot) {
    if (phaseQuerySnapshot.docs.isEmpty) {
      return;
    }
    final phaseOrdinal = Phase(phaseQuerySnapshot.docs[0].data()).ordinal;
    if (phaseOrdinal < newestPhaseOrdinal) {
      return;
    }
    newestPhaseOrdinal = phaseOrdinal;
    StreamSubscription? subscription;
    subscription = cacheDocSnapshots(FirebaseFirestore.instance
            .collection("Game")
            .doc(gameID)
            .collection("Phase")
            .doc(phaseQuerySnapshot.docs[0].id))
        .listen((phaseSnapshot) {
      final phase = Phase(phaseSnapshot.data());
      if (phase.ordinal < newestPhaseOrdinal) {
        subscription?.cancel();
        return;
      }
      phase["ID"] = phaseSnapshot.id;
      lastPhaseStreamController.sink.add(phase);
    });
  });
  return MultiProvider(
    providers: [
      StreamProvider<Game?>.value(
        value: cacheDocSnapshots(
                FirebaseFirestore.instance.collection("Game").doc(gameID))
            .map((snapshot) {
          final res = Game(snapshot.data());
          res["ID"] = snapshot.id;
          return res;
        }),
        catchError: (context, e) => Game({"Error": "gameProvider Game: $e"}),
        initialData: initialData,
      ),
      StreamProvider<Phase?>.value(
        value: lastPhaseStreamController.stream,
        catchError: (context, e) => Phase({"Error": "gameProvider Phase: $e"}),
        initialData: null,
      ),
      ProxyProvider<Game?, Variant?>(
        update: (context, game, __) {
          final variants = context.watch<Variants?>();
          if (game == null) {
            return null;
          }
          if (game.err != null) {
            return Variant({"Error": "gameProvider Game: ${game.err}"});
          }
          if (variants == null) {
            return null;
          }
          if (variants.err != null) {
            return Variant({"Error": "gameProvider Variant: ${variants.err}"});
          }
          return variants.map[game["Variant"] as String];
        },
      ),
    ],
    child: child,
  );
}
