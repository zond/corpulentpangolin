import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router.gr.dart';
import 'configure.dart';
import 'variant.dart';
import 'app_user.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configure();
  final user = StreamController<User?>();
  FirebaseAuth.instance.userChanges().listen((u) {
    user.sink.add(u);
  });
  final appRouter = AppRouter();
  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''),
      Locale('sv', ''),
    ],
    home: MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: user.stream,
          initialData: null,
        ),
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
      builder: (context, child) {
        final user = context.watch<User?>();
        if (user == null) {
          return child!;
        }
        return StreamProvider<AppUser?>.value(
          value: FirebaseFirestore.instance
              .collection("User")
              .doc(user.uid)
              .snapshots()
              .map((snapshot) => AppUser(snapshot.data())),
          initialData: null,
          child: child,
        );
      },
    ),
  ));
}
