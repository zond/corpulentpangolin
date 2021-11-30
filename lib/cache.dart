import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';

Stream<DocumentSnapshot<T>> cacheDocSnapshots<T>(
    DocumentReference<T> doc) async* {
  yield* StreamGroup.merge([
    // We don't care about the FirebaseExceptions here - they happen if the
    // document didn't exist in cache - we'll still just look online instead.
    doc.get(const GetOptions(source: Source.cache)).asStream().handleError(
          (e) {},
          test: (e) => e is FirebaseException,
        ),
    doc.snapshots(),
  ]);
}

Stream<QuerySnapshot<T>> cacheQuerySnapshots<T>(Query<T> query) async* {
  yield* StreamGroup.merge([
    query
        .get(const GetOptions(source: Source.cache))
        .asStream()
        .expand((querySnapshot) {
      if (querySnapshot.size > 0) {
        return [querySnapshot];
      }
      return [];
    }),
    query.snapshots(),
  ]);
}
