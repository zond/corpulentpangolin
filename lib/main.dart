// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:corpulentpangolin/cache.dart';
import 'app_user.dart';
import 'configure.dart';
import 'firebase_options.dart';
import 'router.gr.dart';
import 'variant.dart';

const bool isProd = bool.fromEnvironment("dart.vm.product");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!isProd) {
    FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
    try {
      FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
    } catch (e) {
      debugPrint("Failed to connect to Firestore emulator: $e");
    }
  }
  await configure();
  runApp(_App());
}

class _App extends StatelessWidget {
  final appRouter = AppRouter();
  final variants = Variants.load().asBroadcastStream();
  _App({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ListenableProvider<AppRouter>.value(value: appRouter),
        StreamProvider<User?>.value(
          value: FirebaseAuth.instance.userChanges().asBroadcastStream(),
          initialData: null,
        ),
        StreamProvider<Variants?>.value(
          value: variants,
          initialData: null,
          catchError: (context, e) => Variants.error(e),
        ),
      ],
      builder: (context, child) {
        final user = context.watch<User?>();
        if (user == null) {
          return child!;
        } else {
          return StreamProvider<AppUser?>.value(
            value: cacheDocSnapshots(
                    FirebaseFirestore.instance.collection("User").doc(user.uid))
                .map((userSnapshot) {
              if (!userSnapshot.exists) {
                return AppUser.missing();
              }
              return AppUser(userSnapshot);
            }),
            catchError: (context, err) => AppUser.fromMap({"Error": err}),
            initialData: null,
            child: child,
          );
        }
      },
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
