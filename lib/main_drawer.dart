import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'router.gr.dart';

Drawer mainDrawer(BuildContext context) {
  final appRouter = context.read<AppRouter>();
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          title: const Text("Home"),
          onTap: () => appRouter.push(const HomePageRoute()),
        ),
        ListTile(
          title: const Text("Open games"),
          onTap: () => appRouter.push(const OpenGamesPageRoute()),
        ),
        const ListTile(
          title: Text("Live games"),
        ),
        const ListTile(
          title: Text("Finished games"),
        ),
        ListTile(
          title: const Text("Chat"),
          onTap: () => launch("https://discord.gg/bu3JxYc"),
        ),
        ListTile(
          title: const Text("Forum"),
          onTap: () => launch("https://groups.google.com/g/diplicity-talk"),
        ),
        ListTile(
          title: const Text("Source"),
          onTap: () => launch("https://github.com/zond/corpulentpangolin"),
        ),
      ],
    ),
  );
}
