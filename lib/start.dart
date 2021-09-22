import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'toast.dart';
import 'globals.dart';
import 'auth.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("corpulentpangolin"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          ValueListenableBuilder<User?>(
            valueListenable: user,
            builder: (context, user, child) {
              if (user == null) {
                return PopupMenuButton(
                  icon: Icon(Icons.person),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Log in"),
                      value: 0,
                    ),
                  ],
                  onSelected: (item) {
                    switch (item) {
                      case 0:
                        signInWithGoogle()
                            .then((_) => toast(context, "Logged in"));
                    }
                  },
                );
              } else {
                return PopupMenuButton(
                  icon: Icon(Icons.person),
                  itemBuilder: (context) => [
                    PopupMenuItem(
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
                );
              }
            },
          )
        ],
      ),
      body: withLoginBackground(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text("corpulentpangolin!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget withLoginBackground(Widget widget) {
  return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover),
      ),
      child: widget);
}
