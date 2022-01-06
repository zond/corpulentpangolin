// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'json_map_view.dart';

class AppUser extends JSONMapView {
  AppUser(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super.fromSnapshot(snapshot);

  AppUser.fromMap(Map<String, dynamic> base) : super.fromMap(base);

  AppUser.missing() : super.fromMap({});

  AppUser.error(Object? err) : super.error(err);

  Set<String> get bannedUsers => getList<String>("BannedUsers").toSet();

  Set<String> get bannedByUsers => getList<String>("BannedByUsers").toSet();

  num get reliability => getFloat("Reliability");

  int get nmrPhases => getInt("NMRPhases");

  int get nonNMRPhases => getInt("NonNMRPhases");

  num get quickness => getFloat("Quickness");

  num get committedPhases => getInt("CommittedPhases");

  num get nonCommittedPhases => getInt("NonCommittedPhases");

  num get rating => getFloat("Rating");

  String get pictureURL => getString("PictureURL");

  String get username => getString("Username");
}
