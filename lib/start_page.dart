import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'router.gr.dart';
import 'cache.dart';
import 'toast.dart';
import 'auth.dart';
import 'game_list_widget.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    var appRouter = context.read<AppRouter>();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              onTap: () => appRouter.push(const StartPageRoute()),
            ),
            const ListTile(
              title: Text("Open games"),
            ),
            const ListTile(
              title: Text("Live games"),
            ),
            const ListTile(
              title: Text("Finished games"),
            ),
            ListTile(
              title: const Text("Chat"),
              onTap: () => launch("https://discord.gg/bu3JxYc"),
            ),
            ListTile(
              title: const Text("Forum"),
              onTap: () => launch("https://groups.google.com/g/diplicity-talk"),
            ),
            ListTile(
              title: const Text("Source"),
              onTap: () => launch("https://github.com/zond/corpulentpangolin"),
            ),
          ],
        ),
      ),
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
        ListView(children: [
          if (user == null) ...[
            const Material(
              child: ListTile(
                title: Text("Public games",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
                .collection("Game")
                .where('Private', isEqualTo: false))),
          ],
          if (user != null) ...[
            const Material(
              child: ListTile(
                title: Text("My public games",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
                .collection("Game")
                .where('Private', isEqualTo: false)
                .where('Players', arrayContains: user.uid))),
            const Material(
              child: ListTile(
                title: Text("My private games",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
                .collection("Game")
                .where('Private', isEqualTo: true)
                .where('Players', arrayContains: user.uid))),
          ],
        ]),
      ),
      floatingActionButton: user == null
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => appRouter.push(const CreateGamePageRoute()),
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
