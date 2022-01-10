// Flutter imports:
import 'package:firebase_auth/firebase_auth.dart';
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
import 'app_user.dart';
import 'toast.dart';

@immutable
class ReasonBool {
  final bool value;
  final List<String> reasons;
  const ReasonBool({required this.value, this.reasons = const []});
}

class Game extends JSONMapView {
  Game(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super.fromSnapshot(snapshot);
  Game.fromMap(base) : super.fromMap(base);
  Game.error(Object? err) : super.error(err);

  bool canMuster(User? user) {
    return started &&
        !mustered &&
        user != null &&
        players.contains(user.uid) &&
        !musteredPlayers.contains(user.uid);
  }

  bool hasMustered(User? user) {
    return started &&
        !mustered &&
        user != null &&
        players.contains(user.uid) &&
        musteredPlayers.contains(user.uid);
  }

  Future<Object?> muster(
      {required BuildContext context, required User? user}) async {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (user == null) {
      toast(context, "Not logged in");
      return null;
    }
    final newMusteredPlayers = musteredPlayers.toSet()..add(user.uid);
    await FirebaseFirestore.instance
        .collection("Game")
        .doc(id)
        .update({
          "MusteredPlayers": newMusteredPlayers.toList(),
        })
        .then((_) => toast(context, l10n.markedAsReady))
        .catchError((err) {
          debugPrint("Failed saving game: $err");
          toast(context, "Failed saving game: $err");
        });
    return null;
  }

  Future<Object?> leave(
      {required BuildContext context, required User? user}) async {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (user == null) {
      toast(context, "Not logged in");
      return null;
    }
    await FirebaseFirestore.instance
        .collection("Game")
        .doc(id)
        .update({
          "Players": players.where((id) => id != user.uid).toList(),
        })
        .then((_) => toast(context, l10n.leftGame))
        .catchError((err) {
          debugPrint("Failed saving game: $err");
          toast(context, "Failed saving game: $err");
        });
    return null;
  }

  ReasonBool editable({required BuildContext context, required User? user}) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (user == null) {
      return ReasonBool(value: false, reasons: [l10n.logInToEnableThisButton]);
    }
    if (user.uid != ownerUID) {
      return ReasonBool(
          value: false, reasons: [l10n.youCantEditGamesYouDontOwn]);
    }
    return const ReasonBool(value: true);
  }

  ReasonBool leavable({required BuildContext context, required User? user}) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (user == null) {
      return ReasonBool(value: false, reasons: [l10n.logInToEnableThisButton]);
    }
    if (!players.contains(user.uid)) {
      return ReasonBool(
          value: false, reasons: [l10n.youAreNotAMemberOfThisGame]);
    }
    if (started) {
      return ReasonBool(value: false, reasons: [l10n.youCantLeaveStartedGames]);
    }
    return const ReasonBool(value: true);
  }

  Future<Object?> join(
      {required BuildContext context, required User? user}) async {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (user == null) {
      toast(context, "Not logged in");
      return null;
    }
    await FirebaseFirestore.instance
        .collection("Game")
        .doc(id)
        .update({
          "Players": [...players, user.uid],
        })
        .then((_) => toast(context, l10n.gameJoined))
        .catchError((err) {
          debugPrint("Failed saving game: $err");
          toast(context, "Failed saving game: $err");
        });
    return null;
  }

  ReasonBool joinable(
      {required BuildContext context,
      required User? user,
      required AppUser? appUser,
      required Variant? variant}) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (user == null) {
      return ReasonBool(value: false, reasons: [l10n.logInToEnableThisButton]);
    }
    if (players.contains(user.uid)) {
      return ReasonBool(value: false, reasons: [l10n.youAreAlreadyInGame]);
    }
    if (players.length >= (variant == null ? -1 : variant.nations.length)) {
      return ReasonBool(value: false, reasons: [l10n.gameFull]);
    }
    final isBanned = appUser != null &&
        (appUser.bannedUsers.intersection(players.toSet()).isNotEmpty ||
            appUser.bannedByUsers.intersection(players.toSet()).isNotEmpty);
    final matchesRequirements = (minimumReliability == 0 &&
            minimumQuickness == 0 &&
            minimumRating == 0) ||
        (appUser != null &&
            appUser.reliability >= minimumReliability &&
            appUser.quickness >= minimumQuickness &&
            appUser.rating >= minimumRating);
    final invitationOK =
        !invitationRequired || invitedPlayers.contains(user.uid);
    // TODO(zond): When we have replacement support, this needs more logic.
    final result = !isBanned && invitationOK && matchesRequirements;
    List<String> reasons = [
      if (isBanned) l10n.someoneYouBanned,
      if (!matchesRequirements) l10n.youDonMatchRequirements,
      if (!invitationOK) l10n.thisGameRequiresAnInvitation,
    ];
    return ReasonBool(value: result, reasons: reasons);
  }

  PhaseMeta get phaseMeta => PhaseMeta(getMap("PhaseMeta"));

  bool get hasLimitedStartTime => dontStartAfter != dontStartBefore;

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

  bool get mustered => getBool("Mustered");

  int get gracesPerPlayer => getInt("GracesPerPlayer");

  int get gracesPerPhase => getInt("GracesPerPhase");

  int get extensionsPerPlayer => getInt("ExtensionsPerPlayer");

  int get extensionsPerPhase => getInt("ExtensionsPerPhase");

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

  DateTime get startedAt => getDateTime("StartedAt");

  DateTime get finishedAt => getDateTime("FinishedAt");

  DateTime get createdAt => getDateTime("CreatedAt");

  int get phaseLengthMinutes => getInt("PhaseLengthMinutes");

  int get nonMovementPhaseLengthMinutes =>
      getInt("NonMovementPhaseLengthMinutes");

  bool get finished => getBool("Finished");

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

  bool get seeded => getBool("Seeded");

  bool get isStarted => getBool("Started");

  bool get isFinished => getBool("Finished");

  String get ownerUID => getString("OwnerUID");

  List<String> get invitedPlayers => getList<String>("InvitedPlayers");

  List<String> get players => getList<String>("Players");

  List<String> get musteredPlayers => getList<String>("MusteredPlayers");

  String get desc => getString("Desc");
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
            return Game.error("No game with id $gameID found!");
          }
          return Game(snapshot);
        }),
        catchError: (context, e) {
          debugPrint("gameProvider Game: $e");
          return Game.error("gameProvider Game: $e");
        },
        initialData: initialData,
      ),
      StreamProvider<Phase?>.value(
        value: cacheQuerySnapshots(FirebaseFirestore.instance
                .collection("Game")
                .doc(gameID)
                .collection("Phase")
                .orderBy("Meta.Ordinal", descending: true)
                .limit(1))
            .map((snapshot) {
          if (snapshot.size == 0) {
            return null;
          }
          return Phase(snapshot.docs[0]);
        }),
        catchError: (context, e) {
          debugPrint("gameProvider Phase: $e");
          return Phase.error("gameProvider Phase: $e");
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
            return Variant.error("gameProvider Game: ${game.err}");
          }
          if (variants == null) {
            return null;
          }
          if (variants.err != null) {
            return Variant.error("gameProvider Variant: ${variants.err}");
          }
          return variants.map[game["Variant"] as String];
        },
      ),
    ],
    child: child,
  );
}
