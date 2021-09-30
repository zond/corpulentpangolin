import 'package:corpulentpangolin/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'toast.dart';
import 'globals.dart';
import 'auth.dart';
import 'spinner.dart';

class Start extends StatelessWidget {
  final games = FirebaseFirestore.instance
      .collection("game")
      .where('private', isEqualTo: false)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<User?>(
      valueListenable: user,
      builder: (context, user, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("corpulentpangolin"),
            actions: <Widget>[
              if (user == null)
                PopupMenuButton(
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
                ),
              if (user != null)
                PopupMenuButton(
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
                ),
            ],
          ),
          body: withLoginBackground(
            Center(
              child: Column(
                children: <Widget>[
                  Material(
                    child: ListTile(
                      title: Text("Games"),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: games,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error loading games: ${snapshot.error}",
                            style: TextStyle(backgroundColor: Colors.white));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Spinner();
                      } else {
                        return Column(
                          children: snapshot.data!.docs.map((game) {
                            return ListTile(
                              title: Text("${game.data()}"),
                            );
                          }).toList(),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: user == null
              ? null
              : FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => appRouter.push(CreateGameRoute()),
                ),
        );
      },
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
