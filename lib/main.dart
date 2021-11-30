import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'router.gr.dart';
import 'configure.dart';
import 'variant.dart';

void main() async {
  await configure();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        StreamProvider<Variants?>.value(
          value: Variants.load(),
          initialData: null,
          catchError: (context, e) => Variants.error(e),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
