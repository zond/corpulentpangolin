import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final l10n = context.read<AppLocalizations>();
  return AppBar(
    title: const Text("corpulentpangolin"),
    actions: <Widget>[
      _createMenu(context, [
        if (user == null)
          _MenuItem(
              Text(l10n.login),
              (_) => signInWithGoogle()
                  .then((_) => toast(context, l10n.loggedIn))),
        if (user != null)
          _MenuItem(
              Text(l10n.logout),
              (_) => FirebaseAuth.instance
                  .signOut()
                  .then((_) => toast(context, l10n.loggedOut))),
      ]),
    ],
  );
}