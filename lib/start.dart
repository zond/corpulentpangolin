import 'package:flutter/material.dart';

import 'toast.dart';
import 'spinner.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("corpulentpangolin"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          if (false)
            PopupMenuButton(
              icon: Icon(Icons.person),
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  child: Text("Logout"),
                  value: 0,
                ),
              ],
              onSelected: (item) {
                switch (item) {
                  case 0:
                    toast(context, "Logged out");
                }
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text("corpulentpangolin!"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget withLoginBackground(Widget widget) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/login_background.jpg"),
          fit: BoxFit.cover),
    ),
    child: widget);
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return withLoginBackground(
      Spinner(),
    );
  }
}
