// Dart imports:
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JSONMapView extends MapView<String, dynamic> {
  String id = "";
  bool exists = false;
  Object? err;
  JSONMapView.error(this.err) : super({});
  JSONMapView.fromMap(Map<String, dynamic> base) : super(base);
  JSONMapView.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data() ?? {}) {
    exists = snapshot.exists;
    id = snapshot.id;
  }

  String getString(String key) {
    if (containsKey(key)) {
      return this[key] as String;
    }
    return "";
  }

  DateTime getDateTime(String key) {
    if (containsKey(key)) {
      return (this[key] as Timestamp).toDate();
    }
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  void removeTimestamps() {
    removeWhere((key, value) => value is Timestamp);
  }

  List<T> getList<T>(String key) {
    if (containsKey(key)) {
      return (this[key] as List<dynamic>).map((e) => e as T).toList();
    }
    return [];
  }

  Map<String, T> getMap<T>(String key) {
    if (containsKey(key)) {
      return (this[key] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v as T));
    }
    return {};
  }

  int getInt(String key) {
    if (containsKey(key)) {
      return this[key] as int;
    }
    return 0;
  }

  bool getBool(String key) {
    if (containsKey(key)) {
      return this[key] as bool;
    }
    return false;
  }

  num getFloat(String key) {
    if (containsKey(key)) {
      return this[key] as num;
    }
    return 0.0;
  }
}
