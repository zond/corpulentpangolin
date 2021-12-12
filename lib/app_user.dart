import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

class AppUser extends MapView<String, dynamic> {
  AppUser(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }

  AppUser.fromMap(Map<String, dynamic> base) : super(base);

  AppUser.anon(BuildContext context) : super({}) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    this["Username"] = l10n.anonymous;
  }

  String get username {
    if (containsKey("Username")) {
      return this["Username"] as String;
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
