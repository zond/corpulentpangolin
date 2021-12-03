// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import 'chat_page.dart' as _i5;
import 'create_game_page.dart' as _i2;
import 'game_page.dart' as _i3;
import 'home_page.dart' as _i1;
import 'map_page.dart' as _i4;
import 'orders_page.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CreateGamePageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateGamePage());
    },
    GamePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GamePageRouteArgs>(
          orElse: () =>
              GamePageRouteArgs(gameID: pathParams.getString('gameID')));
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.GamePage(key: args.key, gameID: args.gameID));
    },
    MapPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.MapPage());
    },
    ChatPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ChatPage());
    },
    OrdersPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.OrdersPage());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(HomePageRoute.name, path: '/'),
        _i7.RouteConfig(CreateGamePageRoute.name, path: 'CreateGame'),
        _i7.RouteConfig(GamePageRoute.name, path: '/Game/:gameID', children: [
          _i7.RouteConfig('#redirect',
              path: '',
              parent: GamePageRoute.name,
              redirectTo: 'Map',
              fullMatch: true),
          _i7.RouteConfig(MapPageRoute.name,
              path: 'Map', parent: GamePageRoute.name),
          _i7.RouteConfig(ChatPageRoute.name,
              path: 'Chat', parent: GamePageRoute.name),
          _i7.RouteConfig(OrdersPageRoute.name,
              path: 'Orders', parent: GamePageRoute.name)
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomePageRoute extends _i7.PageRouteInfo<void> {
  const HomePageRoute() : super(name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for [_i2.CreateGamePage]
class CreateGamePageRoute extends _i7.PageRouteInfo<void> {
  const CreateGamePageRoute() : super(name, path: 'CreateGame');

  static const String name = 'CreateGamePageRoute';
}

/// generated route for [_i3.GamePage]
class GamePageRoute extends _i7.PageRouteInfo<GamePageRouteArgs> {
  GamePageRoute(
      {_i8.Key? key, required String gameID, List<_i7.PageRouteInfo>? children})
      : super(name,
            path: '/Game/:gameID',
            args: GamePageRouteArgs(key: key, gameID: gameID),
            rawPathParams: {'gameID': gameID},
            initialChildren: children);

  static const String name = 'GamePageRoute';
}

class GamePageRouteArgs {
  const GamePageRouteArgs({this.key, required this.gameID});

  final _i8.Key? key;

  final String gameID;

  @override
  String toString() {
    return 'GamePageRouteArgs{key: $key, gameID: $gameID}';
  }
}

/// generated route for [_i4.MapPage]
class MapPageRoute extends _i7.PageRouteInfo<void> {
  const MapPageRoute() : super(name, path: 'Map');

  static const String name = 'MapPageRoute';
}

/// generated route for [_i5.ChatPage]
class ChatPageRoute extends _i7.PageRouteInfo<void> {
  const ChatPageRoute() : super(name, path: 'Chat');

  static const String name = 'ChatPageRoute';
}

/// generated route for [_i6.OrdersPage]
class OrdersPageRoute extends _i7.PageRouteInfo<void> {
  const OrdersPageRoute() : super(name, path: 'Orders');

  static const String name = 'OrdersPageRoute';
}
