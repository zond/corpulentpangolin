// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import 'chat_page.dart' as _i6;
import 'create_game_page.dart' as _i2;
import 'game_page.dart' as _i4;
import 'home_page.dart' as _i1;
import 'map_page.dart' as _i5;
import 'open_games_page.dart' as _i3;
import 'orders_page.dart' as _i7;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CreateGamePageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateGamePage());
    },
    OpenGamesPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.OpenGamesPage());
    },
    GamePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GamePageRouteArgs>(
          orElse: () =>
              GamePageRouteArgs(gameID: pathParams.getString('gameID')));
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.GamePage(key: args.key, gameID: args.gameID));
    },
    MapPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.MapPage());
    },
    ChatPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ChatPage());
    },
    OrdersPageRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.OrdersPage());
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(HomePageRoute.name, path: '/'),
        _i8.RouteConfig(CreateGamePageRoute.name, path: 'CreateGame'),
        _i8.RouteConfig(OpenGamesPageRoute.name, path: 'OpenGames'),
        _i8.RouteConfig(GamePageRoute.name, path: '/Game/:gameID', children: [
          _i8.RouteConfig('#redirect',
              path: '',
              parent: GamePageRoute.name,
              redirectTo: 'Map',
              fullMatch: true),
          _i8.RouteConfig(MapPageRoute.name,
              path: 'Map', parent: GamePageRoute.name),
          _i8.RouteConfig(ChatPageRoute.name,
              path: 'Chat', parent: GamePageRoute.name),
          _i8.RouteConfig(OrdersPageRoute.name,
              path: 'Orders', parent: GamePageRoute.name)
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomePageRoute extends _i8.PageRouteInfo<void> {
  const HomePageRoute() : super(name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for [_i2.CreateGamePage]
class CreateGamePageRoute extends _i8.PageRouteInfo<void> {
  const CreateGamePageRoute() : super(name, path: 'CreateGame');

  static const String name = 'CreateGamePageRoute';
}

/// generated route for [_i3.OpenGamesPage]
class OpenGamesPageRoute extends _i8.PageRouteInfo<void> {
  const OpenGamesPageRoute() : super(name, path: 'OpenGames');

  static const String name = 'OpenGamesPageRoute';
}

/// generated route for [_i4.GamePage]
class GamePageRoute extends _i8.PageRouteInfo<GamePageRouteArgs> {
  GamePageRoute(
      {_i9.Key? key, required String gameID, List<_i8.PageRouteInfo>? children})
      : super(name,
            path: '/Game/:gameID',
            args: GamePageRouteArgs(key: key, gameID: gameID),
            rawPathParams: {'gameID': gameID},
            initialChildren: children);

  static const String name = 'GamePageRoute';
}

class GamePageRouteArgs {
  const GamePageRouteArgs({this.key, required this.gameID});

  final _i9.Key? key;

  final String gameID;

  @override
  String toString() {
    return 'GamePageRouteArgs{key: $key, gameID: $gameID}';
  }
}

/// generated route for [_i5.MapPage]
class MapPageRoute extends _i8.PageRouteInfo<void> {
  const MapPageRoute() : super(name, path: 'Map');

  static const String name = 'MapPageRoute';
}

/// generated route for [_i6.ChatPage]
class ChatPageRoute extends _i8.PageRouteInfo<void> {
  const ChatPageRoute() : super(name, path: 'Chat');

  static const String name = 'ChatPageRoute';
}

/// generated route for [_i7.OrdersPage]
class OrdersPageRoute extends _i8.PageRouteInfo<void> {
  const OrdersPageRoute() : super(name, path: 'Orders');

  static const String name = 'OrdersPageRoute';
}
