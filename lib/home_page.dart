// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'cache.dart';
import 'game_list_widget.dart';
import 'main_app_bar.dart';
import 'main_drawer.dart';
import 'router.gr.dart';
import 'with_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    final appRouter = context.read<AppRouter>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return Scaffold(
      drawer: mainDrawer(context),
      appBar: mainAppBar(context),
      body: withBackground(
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              if (user == null)
                Material(
                    child: ListTile(title: Text(l10n.logInToSeeYourGames))),
              if (user != null) ...[
                Material(
                  child: ListTile(
                    title: Text(l10n.myGames,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ),
                GameListWidget(cacheQuerySnapshots(FirebaseFirestore.instance
                    .collection("Game")
                    .where("Players", arrayContains: user.uid)
                    .orderBy("CategorySortKey")
                    .orderBy("TimeSortKey"))),
              ],
            ],
          ),
        ),
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
