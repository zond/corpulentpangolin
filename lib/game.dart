// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'cache.dart';
import 'json_map_view.dart';
import 'phase.dart';
import 'time.dart';
import 'variant.dart';

@immutable
class Game extends JSONMapView {
  Game(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }
  const Game.fromMap(base) : super(base);

  PhaseMeta get phaseMeta => PhaseMeta(getMap("PhaseMeta"));

  bool get exists => containsKey("ID");

  bool get started => getBool("Started");

  int get nmrsBeforeReplaceable => getInt("NMRsBeforeReplaceable");

  bool get hasGrace =>
      gracesPerPlayer > 0 && gracesPerPhase > 0 && graceLengtMinutes > 0;

  bool get hasExtensions => maxExtensionLengthMinutes > 0;

  int get graceLengtMinutes => getInt("GraceLengthMinutes");

  int get maxExtensionLengthMinutes => getInt("MaxExtensionLengthMinutes");

  bool get disableConferenceChat => getBool("DisableConferenceChat");

  bool get disableGroupChat => getBool("DisableGroupChat");

  bool get disablePrivateChat => getBool("DisablePrivateChat");

  bool get invitationRequired => getBool("InvitationRequired");

  bool get musteringRequired => getBool("MusteringRequired");

  int get gracesPerPlayer => getInt("GracesPerPlayer");

  int get gracesPerPhase => getInt("GracesPerPhase");

  int get extensionsPerPlayer => getInt("ExtensionsPerPlayer");

  num get playerRatioForExtraExtensionVote =>
      getFloat("PlayerRatioForExtraExtensionVote");

  String get variant => getString("Variant");

  String phaseLengthDuration(BuildContext context, {bool short = true}) {
    return nanosToDuration(context, phaseLengthMinutes * (1e9 * 60),
        short: short);
  }

  num get minimumReliability => getFloat("MinimumReliability");

  bool get private => getBool("Private");

  num get minimumQuickness => getFloat("MinimumQuickness");

  num get minimumRating => getFloat("MinimumRating");

  String nationSelection(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final selection = this["NationSelection"] as String;
    switch (selection) {
      case "random":
        return l10n.random;
      case "preferences":
        return l10n.preferences;
    }
    return selection;
  }

  Widget combinedPhaseLengthDuration(BuildContext context,
      {bool short = true}) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final res = Row(
      children: [
        Tooltip(
          message: l10n.phaseLength,
          child: Text(phaseLengthDuration(context, short: short)),
        ),
      ],
    );
    if (nonMovementPhaseLengthMinutes != 0 &&
        nonMovementPhaseLengthMinutes != phaseLengthMinutes) {
      res.children.add(const Text("/"));
      res.children.add(Tooltip(
        message: l10n.nonMovementPhaseLength,
        child: Text(nonMovementPhaseLengthDuration(context, short: short)),
      ));
    }
    return res;
  }

  String nonMovementPhaseLengthDuration(BuildContext context,
      {bool short = true}) {
    return nanosToDuration(context, nonMovementPhaseLengthMinutes * (1e9 * 60),
        short: short);
  }

  DateTime get startedAt {
    if (containsKey("StartedAt")) {
      return (this["StartedAt"] as Timestamp).toDate();
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  DateTime get finishedAt {
    if (containsKey("FinishedAt")) {
      return (this["FinishedAt"] as Timestamp).toDate();
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  DateTime get createdAt {
    if (containsKey("CreatedAt")) {
      return (this["CreatedAt"] as Timestamp).toDate();
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  num get phaseLengthMinutes {
    if (containsKey("PhaseLengthMinutes")) {
      return this["PhaseLengthMinutes"] as num;
    }
    return 0;
  }

  num get nonMovementPhaseLengthMinutes {
    if (containsKey("NonMovementPhaseLengthMinutes")) {
      return this["NonMovementPhaseLengthMinutes"] as num;
    }
    return 0;
  }

  bool get finished {
    if (containsKey("Finished")) {
      return this["Finished"] as bool;
    }
    return false;
  }

  TimeOfDay get dontStartBefore {
    if (containsKey("DontStartBeforeMinuteInDay")) {
      final mid = this["DontStartBeforeMinuteInDay"] as int;
      return TimeOfDay(hour: mid ~/ 60, minute: mid % 60);
    }
    return const TimeOfDay(hour: 0, minute: 0);
  }

  TimeOfDay get dontStartAfter {
    if (containsKey("DontStartAfterMinuteInDay")) {
      final mid = this["DontStartAfterMinuteInDay"] as int;
      return TimeOfDay(hour: mid ~/ 60, minute: mid % 60);
    }
    return const TimeOfDay(hour: 0, minute: 0);
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

  String get ownerUID {
    if (containsKey("OwnerUID")) {
      return this["OwnerUID"] as String;
    }
    return "";
  }

  List<String> get players {
    if (containsKey("Players")) {
      return (this["Players"] as List<dynamic>).map((p) => "$p").toList();
    }
    return [];
  }

  String get desc {
    if (containsKey("Desc")) {
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
  return MultiProvider(
    providers: [
      StreamProvider<Game?>.value(
        value: cacheDocSnapshots(
                FirebaseFirestore.instance.collection("Game").doc(gameID))
            .map((snapshot) {
          if (!snapshot.exists) {
            return Game.fromMap({"Error": "No game with id $gameID found!"});
          }
          return Game(snapshot);
        }),
        catchError: (context, e) {
          debugPrint("gameProvider Game: $e");
          return Game.fromMap({"Error": "gameProvider Game: $e"});
        },
        initialData: initialData,
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
          return Phase(snapshot.docs[0]);
        }),
        catchError: (context, e) {
          debugPrint("gameProvider Phase: $e");
          return Phase.fromMap({"Error": "gameProvider Phase: $e"});
        },
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
