import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router.gr.dart';
import 'spinner.dart';
import 'toast.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({Key? key}) : super(key: key);

  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  final game = {
    "CreatorUID": FirebaseAuth.instance.currentUser?.uid,
    "Desc": "",
    "State": "created",
    "Private": false,
    "Players": [FirebaseAuth.instance.currentUser?.uid],
    "Variant": "Classical",
    "DisablePrivateChat": false,
    "DisableGroupChat": false,
    "DisableConferenceChat": false,
  };
  final variants = FirebaseFirestore.instance.collection("Variant").snapshots();
  final gameCollection = FirebaseFirestore.instance.collection("Game");

  @override
  Widget build(BuildContext context) {
    var appRouter = context.read<AppRouter>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("corpulentpangolin"),
      ),
      body: Center(
        child: ListView(
          children: [
            const ListTile(
              title: Text("Create game"),
            ),
            TextFormField(
              initialValue: game["Desc"].toString(),
              decoration: const InputDecoration(
                labelText: "Description",
              ),
              onChanged: (newValue) {
                setState(() => game["Desc"] = newValue);
              },
            ),
            StreamBuilder<QuerySnapshot>(
                stream: variants,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error loading variants: ${snapshot.error}",
                        style: const TextStyle(backgroundColor: Colors.white));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Spinner();
                  } else {
                    return InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Variant",
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: game["Variant"],
                          items: snapshot.data!.docs.map((variant) {
                            return DropdownMenuItem(
                              child: Text(variant.id),
                              value: variant.id,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(
                                () => game["Variant"] = newValue.toString());
                          },
                        ),
                      ),
                    );
                  }
                }),
            Row(
              children: [
                Switch(
                  value: !(game["DisablePrivateChat"] as bool),
                  onChanged: (newValue) {
                    setState(() => game["DisablePrivateChat"] = !newValue);
                  },
                ),
                const Text("Private chat"),
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
                const Text("Group chat"),
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
                const Text("Conference chat"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          debugPrint(game.toString());
          gameCollection.add(game).then((_) {
            appRouter.pop().then((_) => toast(context, "Game created"));
          }).catchError((err) {
            toast(context, "Failed creating game: $err");
          });
        },
      ),
    );
  }
}
