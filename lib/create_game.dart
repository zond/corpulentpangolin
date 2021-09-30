import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'spinner.dart';

class CreateGame extends StatefulWidget {
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
        title: Text("corpulentpangolin"),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: Text("Create game"),
            ),
            TextFormField(
              initialValue: game["desc"].toString(),
              decoration: InputDecoration(
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
                        style: TextStyle(backgroundColor: Colors.white));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Spinner();
                  } else {
                    return InputDecorator(
                      decoration: InputDecoration(
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
