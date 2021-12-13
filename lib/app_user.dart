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

  AppUser.missing(BuildContext context) : super({}) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    this["Username"] = l10n.anonymous;
    this["Exists"] = false;
  }

  String get id {
    if (containsKey("ID")) {
      return this["ID"] as String;
    }
    return "";
  }

  Future<AppUser> save() async {
    remove("Error");
    remove("Exists");
    final _id = id;
    remove("ID");
    await FirebaseFirestore.instance.collection("User").doc(_id).set(this);
    this["ID"] = _id;
    return this;
  }

  bool get exists {
    if (containsKey("Exists")) {
      return this["Exists"] as bool;
    }
    return true;
  }

  String get pictureURL {
    if (containsKey("PictureURL")) {
      return this["PictureURL"] as String;
    }
    return "";
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
