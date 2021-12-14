// Dart imports:
import 'dart:async';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Stream<DocumentSnapshot<T>> cacheDocSnapshots<T>(DocumentReference<T> doc) {
  final streamController = StreamController<DocumentSnapshot<T>>();
  final cacheSubscription = doc
      .get(const GetOptions(source: Source.cache))
      .asStream()
      .handleError((e) {}, test: (e) => e is FirebaseException)
      .listen((docSnapshot) => streamController.sink.add(docSnapshot));
  final liveSubscription = doc.snapshots().listen((docSnapshot) {
    cacheSubscription.cancel();
    streamController.sink.add(docSnapshot);
  });
  streamController.onCancel = () {
    cacheSubscription.cancel();
    liveSubscription.cancel();
  };
  return streamController.stream;
}

Stream<QuerySnapshot<T>> cacheQuerySnapshots<T>(Query<T> query) {
  final streamController = StreamController<QuerySnapshot<T>>();
  final cacheSubscription = query
      .get(const GetOptions(source: Source.cache))
      .asStream()
      .listen((querySnapshot) => streamController.sink.add(querySnapshot));
  final liveSubscription = query.snapshots().listen((querySnapshot) {
    cacheSubscription.cancel();
    streamController.sink.add(querySnapshot);
  });
  streamController.onCancel = () {
    cacheSubscription.cancel();
    liveSubscription.cancel();
  };
  return streamController.stream;
}
