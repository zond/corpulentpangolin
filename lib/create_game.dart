import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'spinner.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({Key? key}) : super(key: key);
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  final game = {
    "creator_uid": FirebaseAuth.instance.currentUser?.uid,
    "desc": "",
    "variant": "Classical",
    "disable_private_chat": false,
    "disable_group_chat": false,
    "disable_conference_chat": false,
  };
  final variants = FirebaseFirestore.instance.collection("variant").snapshots();

  @override
  Widget build(BuildContext context) {
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
              initialValue: game["desc"].toString(),
              decoration: const InputDecoration(
                labelText: "Description",
              ),
              onChanged: (newValue) {
                setState(() => game["desc"] = newValue);
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
                          value: game["variant"],
                          items: snapshot.data!.docs.map((variant) {
                            return DropdownMenuItem(
                              child: Text(variant.id),
                              value: variant.id,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(
                                () => game["variant"] = newValue.toString());
                          },
                        ),
                      ),
                    );
                  }
                }),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: "Private chat",
              ),
              child: Switch(
                value: !(game["disable_private_chat"] as bool),
                onChanged: (newValue) {
                  setState(() => game["disable_private_chat"] = !newValue);
                },
              ),
            ),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: "Group chat",
              ),
              child: Switch(
                value: !(game["disable_group_chat"] as bool),
                onChanged: (newValue) {
                  setState(() => game["disable_group_chat"] = !newValue);
                },
              ),
            ),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: "Conference chat",
              ),
              child: Switch(
                value: !(game["disable_conference_chat"] as bool),
                onChanged: (newValue) {
                  setState(() => game["disable_conference_chat"] = !newValue);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
