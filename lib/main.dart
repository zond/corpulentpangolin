import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'router.gr.dart';
import 'configure.dart';
import 'variants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configure();
  runApp(App());
}

class App extends StatelessWidget {
  final user = ValueNotifier<User?>(null);
  final appRouter = AppRouter();
  App({Key? key}) : super(key: key) {
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
        FutureProvider<Variants?>.value(
            value: Variants.load(context), initialData: null)
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
