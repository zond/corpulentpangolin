import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'router.gr.dart';

class Style {
  String content;
  Style(this.content);
}

class GamePage extends StatelessWidget {
  final String gameID;

  const GamePage({Key? key, @PathParam('gameID') required this.gameID})
      : super(key: key);

  @override
  Widget build(context) {
    final appRouter = context.read<AppRouter>();
    return Provider.value(
      value: Style(""),
      child: gameProvider(
        gameID: gameID,
        child: AutoTabsScaffold(
            routes: const [
              MapPageRoute(),
              ChatPageRoute(),
              OrdersPageRoute(),
            ],
            appBarBuilder: (context, tabsRouter) {
              if (context.router.canPopSelfOrChildren) {
                return AppBar(
                  title: const Text("corpulentpangolin"),
                );
              } else {
                return AppBar(
                  title: const Text("corpulentpangolin"),
                  leading: BackButton(
                    onPressed: () => appRouter.push(const HomePageRoute()),
                  ),
                );
              }
            },
            bottomNavigationBuilder: (_, tabsRouter) {
              return BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.forum), label: "Chat"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.checklist), label: "Orders"),
                ],
              );
            }),
      ),
    );
  }
}
