// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:async/async.dart';
import 'package:brotli/brotli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'cache.dart';
import 'json_map_view.dart';

class SVGBundle {
  final List<int> map;
  final Map<String, List<int>> units;
  final Object? err;
  SVGBundle({required this.map, required this.units, required this.err});
  String? _html;
  String get html {
    return _html ??= () {
      final res = StringBuffer();
      res.write(
          '''<div id="map-svg" style="height:100%;">${String.fromCharCodes(map)}</div>''');
      final sortedUnits = units.entries.toList();
      sortedUnits.sort((a, b) => a.key.compareTo(b.key));
      for (var entry in sortedUnits) {
        res.write(
            '''<div id="unit${entry.key}" style="display: none;">${String.fromCharCodes(entry.value)}</div>''');
      }
      return res.toString();
    }();
  }
}

class Graph extends JSONMapView {
  Graph(base) : super.fromMap(base);
  Map<String, dynamic> get nodes {
    if (!containsKey("Nodes")) {
      return {};
    }
    return this["Nodes"] as Map<String, dynamic>;
  }
}

class Variant extends JSONMapView {
  Variant(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super.fromSnapshot(snapshot);
  Variant.fromMap(base) : super.fromMap(base);
  Variant.error(Object? err) : super.error(err);

  List<int> _decode(DocumentSnapshot<Map<String, dynamic>> doc) {
    return brotliDecode((doc.data()!["Bytes"] as Blob).bytes);
  }

  String get createdBy => getString("CreatedBy");

  String get rules => getString("Rules");

  List<String> get nations => getList<String>("Nations");

  String get description => getString("Description");

  Map<String, String>? _provinceLongNames;
  Map<String, String> get provinceLongNames {
    return _provinceLongNames ??= () {
      if (!containsKey("ProvinceLongNames")) {
        return const {} as Map<String, String>;
      }
      return (this["ProvinceLongNames"] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, "$v"));
    }();
  }

  Graph get graph => Graph(getMap("Graph"));

  Stream<SVGBundle?> get svgs async* {
    List<int>? map;
    Map<String, List<int>>? units;

    List<SVGBundle?> maybeSendBundle() {
      if (map != null && units != null) {
        return [SVGBundle(map: map!, units: units!, err: null)];
      }
      return [];
    }

    final variantDoc = FirebaseFirestore.instance.collection("Variant").doc(id);
    yield* StreamGroup.merge([
      Stream.value(null),
      cacheDocSnapshots(variantDoc.collection("Map").doc("Map"))
          .expand((mapSnapshot) {
        final newMap = _decode(mapSnapshot);
        if (json.encode(newMap) == json.encode(map)) {
          return [];
        }
        map = newMap;
        return maybeSendBundle();
      }),
      cacheQuerySnapshots(variantDoc.collection("Unit"))
          .expand((unitQuerySnapshot) {
        final Map<String, List<int>> newUnits =
            unitQuerySnapshot.docs.fold({}, (m, documentSnapshot) {
          m[documentSnapshot.id] = _decode(documentSnapshot);
          return m;
        });
        if (json.encode(units) == json.encode(newUnits)) {
          return [];
        }
        units = newUnits;
        return maybeSendBundle();
      }),
    ]);
  }
}

@immutable
class Variants {
  final Map<String, Variant> map;
  final List<Variant> list;
  final Object? err;
  const Variants._(this.map, this.list, this.err);
  static Variants error(e) => Variants._(const {}, const [], e);
  static Stream<Variants?> load() {
    return cacheQuerySnapshots(FirebaseFirestore.instance.collection("Variant"))
        .map((variantsQuerySnapshot) {
      final foundVariants = variantsQuerySnapshot.docs
          .fold<Map<String, Variant>>({}, (previousValue, variantSnapshot) {
        previousValue[variantSnapshot.id] = Variant(variantSnapshot);
        return previousValue;
      });
      final List<Variant> orderedVariants = foundVariants.values.toList();
      orderedVariants.sort((a, b) => a.id.compareTo(b.id));
      return Variants._(foundVariants, orderedVariants, null);
    });
  }
}
