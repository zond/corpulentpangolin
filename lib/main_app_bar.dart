import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'toast.dart';
import 'auth.dart';

class _MenuItem {
  final Widget child;
  final Function(BuildContext context) callback;
  const _MenuItem(this.child, this.callback);
}

PopupMenuButton _createMenu(BuildContext context, List<_MenuItem> items) {
  return PopupMenuButton(
    icon: const Icon(Icons.person),
    itemBuilder: (context) => items.asMap().entries.map((entry) {
      return PopupMenuItem(
        child: entry.value.child,
        value: entry.key,
      );
    }).toList(),
    onSelected: (item) => items[item as int].callback(context),
  );
}

AppBar mainAppBar(BuildContext context) {
  final user = context.watch<User?>();
  return AppBar(
    title: const Text("corpulentpangolin"),
    actions: <Widget>[
      _createMenu(context, [
        if (user == null)
          _MenuItem(
              const Text("Log in"),
              (_) =>
                  signInWithGoogle().then((_) => toast(context, "Logged in"))),
        if (user != null)
          _MenuItem(
              const Text("Log out"),
              (_) => FirebaseAuth.instance
                  .signOut()
                  .then((_) => toast(context, "Logged out"))),
      ]),
    ],
  );
}
