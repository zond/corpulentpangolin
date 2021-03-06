// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> configureConditional() async {
  // Hot reloading makes this happen again even after Firestore is initialized,
  // which causes exceptions and complaints.
  try {
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  } catch (e) {
    debugPrint("Failed to enable persistence: $e");
  }
  setUrlStrategy(PathUrlStrategy());
}
