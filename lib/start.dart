import 'package:corpulentpangolin/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'toast.dart';
import 'auth.dart';
import 'game_list.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    var appRouter = context.read<AppRouter>();
    final publicGames = FirebaseFirestore.instance
        .collection("game")
        .where('Private', isEqualTo: false)
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>>? myPublicGames;
    Stream<QuerySnapshot<Map<String, dynamic>>>? myPrivateGames;
    if (user != null) {
      myPublicGames = FirebaseFirestore.instance
          .collection("game")
          .where('Private', isEqualTo: false)
          .where('Players', arrayContains: user.uid)
          .snapshots();
      myPrivateGames = FirebaseFirestore.instance
          .collection("game")
          .where('Private', isEqualTo: true)
          .where('Players', arrayContains: user.uid)
          .snapshots();
      debugPrint(user.uid);
    }
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: withLoginBackground(
        Center(
          child: Column(
            children: <Widget>[
              const Material(
                child: ListTile(
                  title: Text("Public games"),
                ),
              ),
              GameList(publicGames),
              if (user != null) ...[
                const Material(
                  child: ListTile(
                    title: Text("My public games"),
                  ),
                ),
                GameList(myPublicGames!),
                const Material(
                  child: ListTile(
                    title: Text("My private games"),
                  ),
                ),
                GameList(myPrivateGames!),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: user == null
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => appRouter.push(const CreateGameRoute()),
            ),
    );
  }
}

Widget withLoginBackground(Widget widget) {
  return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover),
      ),
      child: widget);
}
