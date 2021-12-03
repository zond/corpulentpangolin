import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'router.gr.dart';
import 'cache.dart';
import 'game_list_widget.dart';
import 'main_app_bar.dart';
import 'main_drawer.dart';
import 'with_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var user = context.watch<User?>();
    var appRouter = context.read<AppRouter>();
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: mainAppBar(context),
      body: withBackground(
        ListView(children: [
          if (user == null)
            const Material(
                child: ListTile(title: Text("Log in to see your games"))),
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
