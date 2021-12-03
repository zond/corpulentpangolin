import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:brotli/brotli.dart';
import 'package:async/async.dart';
import 'package:meta/meta.dart';

import 'cache.dart';

class SVGBundle {
  final List<int> map;
  final Map<String, List<int>> units;
  final Object? err;
  SVGBundle({required this.map, required this.units, required this.err});
  String? _html;
  String get html {
    return _html ??= () {
      final res = StringBuffer();
      res.write('''<div id="map-svg">${String.fromCharCodes(map)}</div>''');
      units.forEach((key, value) {
        res.write(
            '''<div id="unit$key" style="display: none;">${String.fromCharCodes(value)}</div>''');
      });
      return res.toString();
    }();
  }
}

@immutable
class Graph extends MapView<String, dynamic> {
  const Graph(base) : super(base);
  Map<String, dynamic> get nodes {
    if (!containsKey("Nodes")) {
      return {};
    }
    return this["Nodes"] as Map<String, dynamic>;
  }
}

class Variant extends MapView<String, dynamic> {
  Variant(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : super(snapshot.data()!) {
    this["ID"] = snapshot.id;
  }
  Variant.fromMap(base) : super(base);

  List<int> _decode(DocumentSnapshot<Map<String, dynamic>> doc) {
    return brotliDecode((doc.data()!["Bytes"] as Blob).bytes);
  }

  String get id {
    if (containsKey("ID")) {
      return this["ID"] as String;
    }
    return "";
  }

  Object? get err {
    if (containsKey("Error")) {
      return this["Error"];
    }
    return null;
  }

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

  List<String>? _nations;
  List<String> get nations {
    return _nations ??= () {
      if (!containsKey("Nations")) {
        return const [] as List<String>;
      }
      return (this["Nations"] as List<dynamic>).map((nat) => "$nat").toList();
    }();
  }

  Graph get graph {
    if (!containsKey("Graph")) {
      return Graph(const {});
    }
    return Graph(this["Graph"] as Map<String, dynamic>);
  }

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
      cacheDocSnapshots(variantDoc.collection("Map").doc("Map"))
          .expand((mapSnapshot) {
        map = _decode(mapSnapshot);
        return maybeSendBundle();
      }),
      cacheQuerySnapshots(variantDoc.collection("Unit"))
          .expand((unitQuerySnapshot) {
        units = unitQuerySnapshot.docs.fold({}, (m, documentSnapshot) {
          m![documentSnapshot.id] = _decode(documentSnapshot);
          return m;
        });
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
    final variantsStreamController = StreamController<Variants?>();
    final Map<String, Variant> foundVariants = {};
    final List<StreamSubscription> variantSubscriptions = [];
    void pushVariants(
        DocumentSnapshot<Map<String, dynamic>> newVariantSnapshot) {
      foundVariants[newVariantSnapshot.id] = Variant(newVariantSnapshot);
      final List<Variant> orderedVariants = foundVariants.values.toList();
      orderedVariants.sort((a, b) => a.id.compareTo(b.id));
      variantsStreamController.sink
          .add(Variants._(foundVariants, orderedVariants, null));
    }

    final variantsSubscription =
        cacheQuerySnapshots(FirebaseFirestore.instance.collection("Variant"))
            .listen((variantsQuerySnapshot) {
      foundVariants.clear();
      for (var variantSnapshot in variantsQuerySnapshot.docs) {
        pushVariants(variantSnapshot);
      }
      for (var subscription in variantSubscriptions) {
        subscription.cancel();
      }
      variantSubscriptions.clear();
      for (var variantSnapshot in variantsQuerySnapshot.docs) {
        variantSubscriptions.add(cacheDocSnapshots(FirebaseFirestore.instance
                .collection("Variant")
                .doc(variantSnapshot.id))
            .listen((variantSnapshot) => pushVariants(variantSnapshot)));
      }
    });
    variantsStreamController.onCancel = () {
      variantsSubscription.cancel();
      for (var subscription in variantSubscriptions) {
        subscription.cancel();
      }
    };
    return variantsStreamController.stream;
  }
}
