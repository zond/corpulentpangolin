import 'package:auto_route/annotations.dart';
import 'package:corpulentpangolin/profile_page.dart';

import 'home_page.dart';
import 'create_game_page.dart';
import 'game_page.dart';
import 'map_page.dart';
import 'chat_page.dart';
import 'orders_page.dart';
import 'open_games_page.dart';
import 'live_games_page.dart';
import 'finished_games_page.dart';

// To rebuild: flutter packages pub run build_runner build --delete-conflicting-outputs

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, path: '/'),
    AutoRoute(page: CreateGamePage, path: '/CreateGame'),
    AutoRoute(page: OpenGamesPage, path: '/OpenGames'),
    AutoRoute(page: LiveGamesPage, path: '/LiveGames'),
    AutoRoute(page: FinishedGamesPage, path: '/FinishedGames'),
    AutoRoute(page: ProfilePage, path: '/Profile/:uid'),
    AutoRoute(
      page: GamePage,
      path: "/Game/:gameID",
      children: [
        AutoRoute(page: MapPage, path: ''),
        AutoRoute(page: ChatPage, path: 'Chat'),
        AutoRoute(page: OrdersPage, path: 'Orders'),
      ],
    )
  ],
)
class $AppRouter {}
