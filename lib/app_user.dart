import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser extends MapView<String, dynamic> {
  AppUser(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }
}
