import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'conditional_non_html.dart' if (dart.library.html) 'conditional_html.dart';
import 'globals.dart';

Future<void> configureApp() async {
  await Firebase.initializeApp();
  FirebaseAuth.instance.userChanges().listen((u) => user.value = u);
  await configureConditional();
}
