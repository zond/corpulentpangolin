import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'router.gr.dart';
import 'configure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configure();
  runApp(App());
}

class App extends StatelessWidget {
  final ValueNotifier<User?> user = ValueNotifier(null);
  final AppRouter appRouter = AppRouter();
  App({ Key? key }) : super(key: key) {
    FirebaseAuth.instance.userChanges().listen((u) {
      user.value = u;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ValueListenableProvider<User?>.value(value: user),
        ListenableProvider<AppRouter>.value(value: appRouter),
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
