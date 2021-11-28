import 'package:cloud_firestore/cloud_firestore.dart';

Stream<DocumentSnapshot<T>> cacheDocSnapshots<T>(
    DocumentReference<T> doc) async* {
  // We don't care about the FirebaseExceptions here - they happen if the
  // document didn't exist in cache - we'll still just look online instead.
  try {
    yield await doc.get(const GetOptions(source: Source.cache));
  } on FirebaseException {}
  yield* doc.snapshots();
}

Stream<QuerySnapshot<T>> cacheQuerySnapshots<T>(Query<T> query) async* {
  yield await query.get(const GetOptions(source: Source.cache));
  yield* query.snapshots();
}
