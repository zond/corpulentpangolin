import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

@immutable
class Unit {
  final String type;
  final String nation;
  const Unit({required this.type, required this.nation});
}

class Phase extends MapView<String, dynamic> {
  Phase(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }
  Phase.fromMap(Map<String, dynamic> base) : super(base);

  String desc(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    var season = this["Season"] as String;
    switch (season) {
      case "Spring":
        season = l10n.spring;
        break;
      case "Fall":
        season = l10n.fall;
    }
    var type = this["Type"] as String;
    switch (type) {
      case "Adjustment":
        type = l10n.adjustment;
        break;
      case "Movement":
        type = l10n.movement;
        break;
      case "Retreat":
        type = l10n.retreat;
        break;
    }
    return "$season ${this["Year"]}, $type";
  }

  int get ordinal {
    if (!containsKey("Ordinal")) {
      return -1;
    }
    return this["Ordinal"] as int;
  }

  Map<String, String> get supplyCenters {
    if (!containsKey("SCs")) {
      return {};
    }
    return (this["SCs"] as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, "$v"));
  }

  Map<String, Unit>? _units;
  Map<String, Unit> get units {
    if (!containsKey("Units")) {
      return {};
    }
    return _units ??= (this["Units"] as Map<String, dynamic>).map((k, v) {
      final unit = v as Map<String, dynamic>;
      return MapEntry(
          k, Unit(type: "${unit["Type"]}", nation: "${unit["Nation"]}"));
    });
  }

  Object? get err {
    if (containsKey("Error")) {
      return this["Error"];
    }
    return null;
  }
}
