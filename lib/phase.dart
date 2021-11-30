import 'dart:collection';
import 'package:meta/meta.dart';

@immutable
class Unit {
  final String type;
  final String nation;
  const Unit({required this.type, required this.nation});
}

class Phase extends MapView<String, dynamic> {
  Phase(base) : super(base);
  String desc() {
    return "${this["Season"]} ${this["Year"]}, ${this["Type"]}";
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

  Object? get err {
    if (containsKey("Error")) {
      return this["Error"];
    }
    return null;
  }
}
