import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cache.dart';
import 'game_list_widget.dart';
import 'main_app_bar.dart';
import 'main_drawer.dart';
import 'with_background.dart';

class OpenGamesPage extends StatelessWidget {
  const OpenGamesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: mainAppBar(context),
      body: withBackground(
        ListView(children: [
          const Material(
            child: ListTile(
              title: Text("Open games",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
              .collection("Game")
              .where('Private', isEqualTo: false))),
        ]),
      ),
    );
  }
}
