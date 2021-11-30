import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:brotli/brotli.dart';
import 'package:async/async.dart';

import 'cache.dart';

@immutable
class SVGBundle {
  final List<int> map;
  final Map<String, List<int>> flags;
  final Map<String, List<int>> units;
  final Object? err;
  const SVGBundle(
      {required this.map,
      required this.flags,
      required this.units,
      required this.err});
}

class Variant extends MapView<String, dynamic> {
  Variant(base) : super(base);
  List<int> _decode(DocumentSnapshot<Map<String, dynamic>> doc) {
    return brotliDecode((doc.data()!["Bytes"] as Blob).bytes);
  }

  Object? get err {
    if (containsKey("Error")) {
      return this["Error"];
    }
    return null;
  }

  Stream<SVGBundle?> get svgs async* {
    List<int>? map;
    Map<String, List<int>>? flags;
    Map<String, List<int>>? units;

    List<SVGBundle?> maybeSendBundle() {
      if (map != null && flags != null && units != null) {
        return [SVGBundle(map: map!, flags: flags!, units: units!, err: null)];
      }
      return [];
    }

    final variantDoc = FirebaseFirestore.instance
        .collection("Variant")
        .doc(this["ID"] as String);
    yield* StreamGroup.merge([
      cacheDocSnapshots(variantDoc.collection("Map").doc("Map"))
          .expand((mapSnapshot) {
        map = _decode(mapSnapshot);
        return maybeSendBundle();
      }),
      cacheQuerySnapshots(variantDoc.collection("Flag"))
          .expand((flagQuerySnapshot) {
        flags = flagQuerySnapshot.docs.fold({}, (m, documentSnapshot) {
          m![documentSnapshot.id] = _decode(documentSnapshot);
          return m;
        });
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
  static Stream<Variants?> load() async* {
    yield* cacheQuerySnapshots(FirebaseFirestore.instance.collection("Variant"))
        .map((querySnapshot) {
      final Map<String, Variant> map = {};
      final List<Variant> list = [];
      querySnapshot.docs.sort((QueryDocumentSnapshot<Map<String, dynamic>> a,
              QueryDocumentSnapshot<Map<String, dynamic>> b) =>
          a.id.compareTo(b.id));
      for (final variantDoc in querySnapshot.docs) {
        final variant = Variant(variantDoc.data());
        variant["ID"] = variantDoc.id;
        map[variantDoc.id] = variant;
        list.add(variant);
      }
      return Variants._(map, list, null);
    });
  }
}
