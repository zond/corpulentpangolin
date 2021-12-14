// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
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
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
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
                  title: Text(l10n.appName),
                );
              } else {
                return AppBar(
                  title: Text(l10n.appName),
                  leading: BackButton(
                    onPressed: () => appRouter.replace(const HomePageRoute()),
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
