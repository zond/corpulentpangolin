import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'router.gr.dart';
import 'spinner_widget.dart';
import 'toast.dart';
import 'variant.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final game = {
    "CreatorUID": FirebaseAuth.instance.currentUser?.uid,
    "OwnerUID": "",
    "MusteringRequired": true,
    "Desc": "",
    "State": "created",
    "PhaseLengthMinutes": 1440,
    "MinReliability": 0.0,
    "MinQuickness": 0.0,
    "MinRating": 0.0,
    "Private": false,
    "DisablePrivateChat": false,
    "DisableGroupChat": false,
    "DisableConferenceChat": false,
    "Variant": "Classical",
    "Players": [FirebaseAuth.instance.currentUser?.uid],
    "CategorySortKey": 1000,
  };
  final gameCollection = FirebaseFirestore.instance.collection("Game");

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<AppRouter>();
    final variants = context.watch<Variants?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    if (variants != null && variants.err != null) {
      return Text("Variants error: ${variants.err}");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("corpulentpangolin"),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text(l10n.createGame),
            ),
            TextFormField(
              initialValue: game["Desc"].toString(),
              decoration: InputDecoration(
                labelText: l10n.description,
              ),
              onChanged: (newValue) {
                setState(() => game["Desc"] = newValue);
              },
            ),
            variants == null
                ? const SpinnerWidget()
                : InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.variant,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: game["Variant"],
                        items: variants.list.map((variant) {
                          return DropdownMenuItem(
                            child: Text(variant["Name"].toString()),
                            value: variant["Name"].toString(),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() => game["Variant"] = newValue.toString());
                        },
                      ),
                    ),
                  ),
            Row(
              children: [
                Switch(
                  value: !(game["DisablePrivateChat"] as bool),
                  onChanged: (newValue) {
                    setState(() => game["DisablePrivateChat"] = !newValue);
                  },
                ),
                Text(l10n.privateChat),
              ],
            ),
            Row(
              children: [
                Switch(
                  value: !(game["DisableGroupChat"] as bool),
                  onChanged: (newValue) {
                    setState(() => game["DisableGroupChat"] = !newValue);
                  },
                ),
                Text(l10n.groupChat),
              ],
            ),
            Row(
              children: [
                Switch(
                  value: !(game["DisableConferenceChat"] as bool),
                  onChanged: (newValue) {
                    setState(() => game["DisableConferenceChat"] = !newValue);
                  },
                ),
                Text(l10n.publicChat),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          gameCollection.add(game).then((_) {
            appRouter.pop().then((_) => toast(context, l10n.gameCreated));
          }).catchError((err) {
            toast(context, l10n.failedCreatingGameErr("$err"));
          });
        },
      ),
    );
  }
}
