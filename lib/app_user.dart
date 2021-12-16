// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'json_map_view.dart';

class AppUser extends JSONMapView {
  AppUser(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }

  AppUser.fromMap(Map<String, dynamic> base) : super(base);

  AppUser.missing() : super({}) {
    this["Exists"] = false;
  }

  Set<String> get bannedUsers => getList<String>("BannedUsers").toSet();

  Set<String> get bannedByUsers => getList<String>("BannedByUsers").toSet();

  String get id => getString("ID");

  num get reliability => getFloat("Reliability");

  int get nmrPhases => getInt("NMRPhases");

  int get nonNMRPhases => getInt("NonNMRPhases");

  num get quickness => getFloat("Quickness");

  num get committedPhases => getInt("CommittedPhases");

  num get nonCommittedPhases => getInt("NonCommittedPhases");

  num get rating => getFloat("Rating");

  bool get exists {
    if (containsKey("Exists")) {
      return this["Exists"] as bool;
    }
    return true;
  }

  String get pictureURL => getString("PictureURL");

  String get username => getString("Username");

  Object? get err => this["Error"];
}
