import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final l10n = context.read<AppLocalizations>();
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
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.map), label: l10n.map),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.forum), label: l10n.chat),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.checklist), label: l10n.orders),
                ],
              );
            }),
      ),
    );
  }
}
