import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> configureConditional() async {
  // Hot reloading makes this happen again even after Firestore is initialized,
  // which causes exceptions and complaints.
  try {
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } catch (e) {}
  setUrlStrategy(PathUrlStrategy());
}
