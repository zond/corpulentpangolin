import 'dart:collection';

class Phase extends MapView<String, dynamic> {
  const Phase(base) : super(base);
  String desc() {
    return "${this["Season"]} ${this["Year"]}, ${this["Type"]}";
  }
}
