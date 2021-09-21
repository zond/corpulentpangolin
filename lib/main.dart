import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'conditional.dart';
import 'globals.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: configureApp(),
      builder: (context, snapshot) {
        return MaterialApp.router(
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
