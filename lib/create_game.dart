import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'spinner.dart';

class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  final game = {
    "Variant": "Classical",
  };
  final variants = FirebaseFirestore.instance.collection("variant").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("corpulentpangolin"),
      ),
      body: Center(
        child: Column(
          children: [
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
                    debugPrint("${snapshot.data!.docs.first.id}");
                    return DropdownButton(
                      value: game["Variant"],
                      items: snapshot.data!.docs.map((variant) {
                        return DropdownMenuItem(
                          child: Text(variant.id),
                          value: variant.id,
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() => game["Variant"] = newValue.toString());
                      },
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
