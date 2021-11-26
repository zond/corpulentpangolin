import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'toast.dart';

@immutable
class Variants {
  final Map<String, Map<String, dynamic>> map;
  final List<Map<String, dynamic>> list;
  const Variants._(this.map, this.list);
  static Future<Variants>? load(BuildContext context) {
    return FirebaseFirestore.instance
        .collection("Variant")
        .get()
        .then((variantsSnapshot) async {
      final Map<String, Map<String, dynamic>> map = {};
      final List<Map<String, dynamic>> list = [];
      variantsSnapshot.docs.sort((QueryDocumentSnapshot<Map<String, dynamic>> a,
              QueryDocumentSnapshot<Map<String, dynamic>> b) =>
          a.id.compareTo(b.id));
      for (final variant in variantsSnapshot.docs) {
        map[variant.id] = variant.data();
        list.add(variant.data());
      }
      return Variants._(map, list);
    }).catchError((err) {
      toast(context, "Error loading variants: $err");
    });
  }
}
