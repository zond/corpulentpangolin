import 'dart:async';

import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'phase.dart';
import 'variant.dart';
import 'cache.dart';
import 'time.dart';

@immutable
class Game extends MapView<String, dynamic> {
  Game(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }
  const Game.fromMap(base) : super(base);

  bool get started {
    if (containsKey("Started")) {
      return this["Started"] as bool;
    }
    return false;
  }

  String get variant {
    if (containsKey("Variant")) {
      return this["Variant"] as String;
    }
    return "";
  }

  String phaseLengthDuration(BuildContext context, {bool short = true}) {
    return nanosToDuration(context, phaseLengthMinutes * (1e9 * 60));
  }

  DateTime get startedAt {
    if (containsKey("StartedAt")) {
      return DateTime.fromMicrosecondsSinceEpoch(
          (this["StartedAt"] as num) ~/ 1000);
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  DateTime get finishedAt {
    if (containsKey("FinishedAt")) {
      return DateTime.fromMicrosecondsSinceEpoch(
          (this["FinishedAt"] as num) ~/ 1000);
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  DateTime get createdAt {
    if (containsKey("CreatedAt")) {
      return DateTime.fromMicrosecondsSinceEpoch(
          (this["CreatedAt"] as num) ~/ 1000);
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  num get phaseLengthMinutes {
    if (containsKey("PhaseLengthMinutes")) {
      return this["PhaseLengthMinutes"] as num;
    }
    return 0;
  }

  bool get finished {
    if (containsKey("Finished")) {
      return this["Finished"] as bool;
    }
    return false;
  }

  bool get seeded {
    if (containsKey("Seeded")) {
      return this["Seeded"] as bool;
    }
    return false;
  }

  String get id {
    if (containsKey("ID")) {
      return this["ID"] as String;
    }
    return "no-id";
  }

  bool get isStarted {
    if (containsKey("Started")) {
      return this["Started"] as bool;
    }
    return false;
  }

  bool get isFinished {
    if (containsKey("Finished")) {
      return this["Finished"] as bool;
    }
    return false;
  }

  String get desc {
    if (containsKey("Decs")) {
      return this["Desc"] as String;
    }
    return "";
  }

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
  StreamSubscription? newestPhaseSubscription;
  final lastPhaseSubscription = cacheQuerySnapshots(FirebaseFirestore.instance
          .collection("Game")
          .doc(gameID)
          .collection("Phase")
          .orderBy("Ordinal", descending: true)
          .limit(1))
      .listen((phaseQuerySnapshot) {
    if (phaseQuerySnapshot.docs.isEmpty) {
      return;
    }
    final phase = Phase(phaseQuerySnapshot.docs[0]);
    if (phase.ordinal < newestPhaseOrdinal) {
      return;
    }
    lastPhaseStreamController.sink.add(phase);
    newestPhaseOrdinal = phase.ordinal;
    newestPhaseSubscription = cacheDocSnapshots(FirebaseFirestore.instance
            .collection("Game")
            .doc(gameID)
            .collection("Phase")
            .doc(phaseQuerySnapshot.docs[0].id))
        .listen((phaseSnapshot) {
      final phase = Phase(phaseSnapshot);
      if (phase.ordinal < newestPhaseOrdinal) {
        newestPhaseSubscription?.cancel();
        return;
      }
      lastPhaseStreamController.sink.add(phase);
    });
  });
  lastPhaseStreamController.onCancel = () {
    lastPhaseSubscription.cancel();
    newestPhaseSubscription?.cancel();
  };
  return MultiProvider(
    providers: [
      StreamProvider<Game?>.value(
        value: cacheDocSnapshots(
                FirebaseFirestore.instance.collection("Game").doc(gameID))
            .map((snapshot) => Game(snapshot)),
        catchError: (context, e) =>
            Game.fromMap({"Error": "gameProvider Game: $e"}),
        initialData: initialData,
      ),
      StreamProvider<Phase?>.value(
        value: lastPhaseStreamController.stream,
        catchError: (context, e) =>
            Phase.fromMap({"Error": "gameProvider Phase: $e"}),
        initialData: null,
      ),
      ProxyProvider<Game?, Variant?>(
        update: (context, game, __) {
          final variants = context.watch<Variants?>();
          if (game == null) {
            return null;
          }
          if (game.err != null) {
            return Variant.fromMap({"Error": "gameProvider Game: ${game.err}"});
          }
          if (variants == null) {
            return null;
          }
          if (variants.err != null) {
            return Variant.fromMap(
                {"Error": "gameProvider Variant: ${variants.err}"});
          }
          return variants.map[game["Variant"] as String];
        },
      ),
    ],
    child: child,
  );
}
