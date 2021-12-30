// Dart imports:
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class JSONMapView extends MapView<String, dynamic> {
  const JSONMapView(Map<String, dynamic> base) : super(base);

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
