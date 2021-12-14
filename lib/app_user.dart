import 'package:cloud_firestore/cloud_firestore.dart';

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

  String get id => getString("ID");

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

  String get pictureURL => getString("PictureURL");

  String get username => getString("Username");

  Object? get err => this["Error"];
}
