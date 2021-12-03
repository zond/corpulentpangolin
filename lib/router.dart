import 'package:auto_route/annotations.dart';

import 'home_page.dart';
import 'create_game_page.dart';
import 'game_page.dart';
import 'map_page.dart';
import 'chat_page.dart';
import 'orders_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: CreateGamePage, path: 'CreateGame'),
    AutoRoute(
      page: GamePage,
      path: "/Game/:gameID",
      children: [
        AutoRoute(page: MapPage, path: 'Map', initial: true),
        AutoRoute(page: ChatPage, path: 'Chat'),
        AutoRoute(page: OrdersPage, path: 'Orders'),
      ],
    )
  ],
)
class $AppRouter {}
