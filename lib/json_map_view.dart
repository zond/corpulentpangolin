import 'dart:collection';

class JSONMapView extends MapView<String, dynamic> {
  const JSONMapView(Map<String, dynamic> base) : super(base);

  String getString(String key) {
    if (containsKey(key)) {
      return this[key] as String;
    }
    return "";
  }

  Map<String, dynamic> getMap(String key) {
    if (containsKey(key)) {
      return this[key] as Map<String, dynamic>;
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
