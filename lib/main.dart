import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'conditional.dart' if (dart.library.html) 'conditional_html.dart';
import 'globals.dart';

void main() async {
  configureApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      builder: (context, snapshot) {
        return MaterialApp.router(
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
