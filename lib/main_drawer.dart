// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'router.gr.dart';

Drawer mainDrawer(BuildContext context) {
  final appRouter = context.read<AppRouter>();
  final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text(l10n.home),
          onTap: () => appRouter.push(const HomePageRoute()),
        ),
        ListTile(
          title: Text(l10n.openGames),
          onTap: () => appRouter.push(const OpenGamesPageRoute()),
        ),
        ListTile(
          title: Text(l10n.liveGames),
          onTap: () => appRouter.push(const LiveGamesPageRoute()),
        ),
        ListTile(
            title: Text(l10n.finishedGames),
            onTap: () => appRouter.push(const FinishedGamesPageRoute())),
        ListTile(
          title: Text(l10n.chat),
          onTap: () => launch("https://discord.gg/bu3JxYc"),
        ),
        ListTile(
          title: Text(l10n.forum),
          onTap: () => launch("https://groups.google.com/g/diplicity-talk"),
        ),
        ListTile(
          title: Text(l10n.source),
          onTap: () => launch("https://github.com/zond/corpulentpangolin"),
        ),
      ],
    ),
  );
}
