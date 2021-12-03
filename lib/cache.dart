import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

Stream<DocumentSnapshot<T>> cacheDocSnapshots<T>(DocumentReference<T> doc) {
  final streamController = StreamController<DocumentSnapshot<T>>();
  final subscription = doc
      .get(const GetOptions(source: Source.cache))
      .asStream()
      .handleError((e) {}, test: (e) => e is FirebaseException)
      .listen((docSnapshot) => streamController.sink.add(docSnapshot));
  doc.snapshots().listen((docSnapshot) {
    subscription.cancel();
    streamController.sink.add(docSnapshot);
  });
  return streamController.stream;
}

Stream<QuerySnapshot<T>> cacheQuerySnapshots<T>(Query<T> query) {
  final streamController = StreamController<QuerySnapshot<T>>();
  final subscription = query
      .get(const GetOptions(source: Source.cache))
      .asStream()
      .listen((querySnapshot) => streamController.sink.add(querySnapshot));
  query.snapshots().listen((querySnapshot) {
    subscription.cancel();
    streamController.sink.add(querySnapshot);
  });
  return streamController.stream;
}
