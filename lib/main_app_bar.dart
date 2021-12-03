import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'toast.dart';
import 'auth.dart';

AppBar mainAppBar(BuildContext context) {
  final user = context.watch<User?>();
  return AppBar(
    title: const Text("corpulentpangolin"),
    actions: <Widget>[
      if (user == null)
        PopupMenuButton(
          icon: const Icon(Icons.person),
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: Text("Log in"),
              value: 0,
            ),
          ],
          onSelected: (item) {
            switch (item) {
              case 0:
                signInWithGoogle().then((_) => toast(context, "Logged in"));
            }
          },
        ),
      if (user != null)
        PopupMenuButton(
          icon: const Icon(Icons.person),
          itemBuilder: (context) => [
            const PopupMenuItem(
              child: Text("Log out"),
              value: 0,
            ),
          ],
          onSelected: (item) {
            switch (item) {
              case 0:
                FirebaseAuth.instance
                    .signOut()
                    .then((_) => toast(context, "Logged out"));
            }
          },
        ),
    ],
  );
}
