import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'router.gr.dart';

Drawer mainDrawer(BuildContext context) {
  final appRouter = context.read<AppRouter>();
  final l10n = context.read<AppLocalizations>();
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
        ),
        ListTile(
          title: Text(l10n.finishedGames),
        ),
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
