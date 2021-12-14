import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';

import 'json_map_view.dart';

@immutable
class Unit {
  final String type;
  final String nation;
  const Unit({required this.type, required this.nation});
}

class PhaseMeta extends JSONMapView {
  PhaseMeta(Map<String, dynamic> base) : super(base);

  String get season => getString("Season");

  String get type => getString("Type");

  String desc(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    String _season = season;
    switch (_season) {
      case "Spring":
        _season = l10n.spring;
        break;
      case "Fall":
        _season = l10n.fall;
    }
    String _type = type;
    switch (_type) {
      case "Adjustment":
        _type = l10n.adjustment;
        break;
      case "Movement":
        _type = l10n.movement;
        break;
      case "Retreat":
        _type = l10n.retreat;
        break;
    }
    return "$_season $year, $_type";
  }

  int get ordinal => getInt("Ordinal");

  int get year => getInt("Year");
}

class Phase extends JSONMapView {
  Phase(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }
  Phase.fromMap(Map<String, dynamic> base) : super(base);

  PhaseMeta get meta => PhaseMeta(getMap("Meta"));

  String desc(BuildContext context) {
    return meta.desc(context);
  }

  int get ordinal {
    return meta.ordinal;
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

  Object? get err => this["Error"];
}
