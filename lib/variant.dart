import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:brotli/brotli.dart';

import 'toast.dart';

class Variant extends MapView<String, dynamic> {
  Future<List<int>>? _mapSVG;
  Map<String, Future<List<int>>>? _flagSVGs;
  Map<String, Future<List<int>>>? _unitSVGs;
  Variant(base) : super(base);
  Future<List<int>> get mapSVG {
    _mapSVG ??= FirebaseFirestore.instance
        .collection("Variant")
        .doc(this["ID"] as String)
        .collection("Map")
        .doc("Map")
        .get()
        .then((snapshot) {
      return brotliDecode((snapshot.data()!["Bytes"] as Blob).bytes);
    });
    return _mapSVG!;
  }
}

@immutable
class Variants {
  final Map<String, Variant> map;
  final List<Variant> list;
  const Variants._(this.map, this.list);
  static Future<Variants>? load(BuildContext context) {
    return FirebaseFirestore.instance
        .collection("Variant")
        .get()
        .then((variantsSnapshot) async {
      final Map<String, Variant> map = {};
      final List<Variant> list = [];
      variantsSnapshot.docs.sort((QueryDocumentSnapshot<Map<String, dynamic>> a,
              QueryDocumentSnapshot<Map<String, dynamic>> b) =>
          a.id.compareTo(b.id));
      for (final variantDoc in variantsSnapshot.docs) {
        final variant = Variant(variantDoc.data());
        variant["ID"] = variantDoc.id;
        map[variantDoc.id] = variant;
        list.add(variant);
      }
      return Variants._(map, list);
    }).catchError((err) {
      toast(context, "Error loading variants: $err");
    });
  }
}
