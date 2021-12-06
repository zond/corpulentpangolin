// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import 'chat_page.dart' as _i8;
import 'create_game_page.dart' as _i2;
import 'finished_games_page.dart' as _i5;
import 'game_page.dart' as _i6;
import 'home_page.dart' as _i1;
import 'live_games_page.dart' as _i4;
import 'map_page.dart' as _i7;
import 'open_games_page.dart' as _i3;
import 'orders_page.dart' as _i9;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CreateGamePageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateGamePage());
    },
    OpenGamesPageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.OpenGamesPage());
    },
    LiveGamesPageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.LiveGamesPage());
    },
    FinishedGamesPageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.FinishedGamesPage());
    },
    GamePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GamePageRouteArgs>(
          orElse: () =>
              GamePageRouteArgs(gameID: pathParams.getString('gameID')));
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.GamePage(key: args.key, gameID: args.gameID));
    },
    MapPageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.MapPage());
    },
    ChatPageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ChatPage());
    },
    OrdersPageRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.OrdersPage());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(HomePageRoute.name, path: '/'),
        _i10.RouteConfig(CreateGamePageRoute.name, path: '/CreateGame'),
        _i10.RouteConfig(OpenGamesPageRoute.name, path: '/OpenGames'),
        _i10.RouteConfig(LiveGamesPageRoute.name, path: '/LiveGames'),
        _i10.RouteConfig(FinishedGamesPageRoute.name, path: '/FinishedGames'),
        _i10.RouteConfig(GamePageRoute.name, path: '/Game/:gameID', children: [
          _i10.RouteConfig(MapPageRoute.name,
              path: '', parent: GamePageRoute.name),
          _i10.RouteConfig(ChatPageRoute.name,
              path: 'Chat', parent: GamePageRoute.name),
          _i10.RouteConfig(OrdersPageRoute.name,
              path: 'Orders', parent: GamePageRoute.name)
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomePageRoute extends _i10.PageRouteInfo<void> {
  const HomePageRoute() : super(name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for [_i2.CreateGamePage]
class CreateGamePageRoute extends _i10.PageRouteInfo<void> {
  const CreateGamePageRoute() : super(name, path: '/CreateGame');

  static const String name = 'CreateGamePageRoute';
}

/// generated route for [_i3.OpenGamesPage]
class OpenGamesPageRoute extends _i10.PageRouteInfo<void> {
  const OpenGamesPageRoute() : super(name, path: '/OpenGames');

  static const String name = 'OpenGamesPageRoute';
}

/// generated route for [_i4.LiveGamesPage]
class LiveGamesPageRoute extends _i10.PageRouteInfo<void> {
  const LiveGamesPageRoute() : super(name, path: '/LiveGames');

  static const String name = 'LiveGamesPageRoute';
}

/// generated route for [_i5.FinishedGamesPage]
class FinishedGamesPageRoute extends _i10.PageRouteInfo<void> {
  const FinishedGamesPageRoute() : super(name, path: '/FinishedGames');

  static const String name = 'FinishedGamesPageRoute';
}

/// generated route for [_i6.GamePage]
class GamePageRoute extends _i10.PageRouteInfo<GamePageRouteArgs> {
  GamePageRoute(
      {_i11.Key? key,
      required String gameID,
      List<_i10.PageRouteInfo>? children})
      : super(name,
            path: '/Game/:gameID',
            args: GamePageRouteArgs(key: key, gameID: gameID),
            rawPathParams: {'gameID': gameID},
            initialChildren: children);

  static const String name = 'GamePageRoute';
}

class GamePageRouteArgs {
  const GamePageRouteArgs({this.key, required this.gameID});

  final _i11.Key? key;

  final String gameID;

  @override
  String toString() {
    return 'GamePageRouteArgs{key: $key, gameID: $gameID}';
  }
}

/// generated route for [_i7.MapPage]
class MapPageRoute extends _i10.PageRouteInfo<void> {
  const MapPageRoute() : super(name, path: '');

  static const String name = 'MapPageRoute';
}

/// generated route for [_i8.ChatPage]
class ChatPageRoute extends _i10.PageRouteInfo<void> {
  const ChatPageRoute() : super(name, path: 'Chat');

  static const String name = 'ChatPageRoute';
}

/// generated route for [_i9.OrdersPage]
class OrdersPageRoute extends _i10.PageRouteInfo<void> {
  const OrdersPageRoute() : super(name, path: 'Orders');

  static const String name = 'OrdersPageRoute';
}
