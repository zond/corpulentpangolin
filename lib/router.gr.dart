// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import 'chat_page.dart' as _i10;
import 'create_game_page.dart' as _i2;
import 'edit_game_page.dart' as _i7;
import 'finished_games_page.dart' as _i5;
import 'game.dart' as _i14;
import 'game_page.dart' as _i8;
import 'home_page.dart' as _i1;
import 'live_games_page.dart' as _i4;
import 'map_page.dart' as _i9;
import 'open_games_page.dart' as _i3;
import 'orders_page.dart' as _i11;
import 'profile_page.dart' as _i6;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CreateGamePageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateGamePage());
    },
    OpenGamesPageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.OpenGamesPage());
    },
    LiveGamesPageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.LiveGamesPage());
    },
    FinishedGamesPageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.FinishedGamesPage());
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () => ProfilePageRouteArgs(uid: pathParams.getString('uid')));
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.ProfilePage(key: args.key, uid: args.uid));
    },
    EditGamePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditGamePageRouteArgs>(
          orElse: () =>
              EditGamePageRouteArgs(gameID: pathParams.getString('gameID')));
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.EditGamePage(
              key: args.key,
              gameID: args.gameID,
              initialData: args.initialData));
    },
    GamePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GamePageRouteArgs>(
          orElse: () =>
              GamePageRouteArgs(gameID: pathParams.getString('gameID')));
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.GamePage(key: args.key, gameID: args.gameID));
    },
    MapPageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.MapPage());
    },
    ChatPageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.ChatPage());
    },
    OrdersPageRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.OrdersPage());
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(HomePageRoute.name, path: '/'),
        _i12.RouteConfig(CreateGamePageRoute.name, path: '/CreateGame'),
        _i12.RouteConfig(OpenGamesPageRoute.name, path: '/OpenGames'),
        _i12.RouteConfig(LiveGamesPageRoute.name, path: '/LiveGames'),
        _i12.RouteConfig(FinishedGamesPageRoute.name, path: '/FinishedGames'),
        _i12.RouteConfig(ProfilePageRoute.name, path: '/Profile/:uid'),
        _i12.RouteConfig(EditGamePageRoute.name, path: '/Edit/:gameID'),
        _i12.RouteConfig(GamePageRoute.name, path: '/Game/:gameID', children: [
          _i12.RouteConfig(MapPageRoute.name,
              path: '', parent: GamePageRoute.name),
          _i12.RouteConfig(ChatPageRoute.name,
              path: 'Chat', parent: GamePageRoute.name),
          _i12.RouteConfig(OrdersPageRoute.name,
              path: 'Orders', parent: GamePageRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i12.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.CreateGamePage]
class CreateGamePageRoute extends _i12.PageRouteInfo<void> {
  const CreateGamePageRoute()
      : super(CreateGamePageRoute.name, path: '/CreateGame');

  static const String name = 'CreateGamePageRoute';
}

/// generated route for
/// [_i3.OpenGamesPage]
class OpenGamesPageRoute extends _i12.PageRouteInfo<void> {
  const OpenGamesPageRoute()
      : super(OpenGamesPageRoute.name, path: '/OpenGames');

  static const String name = 'OpenGamesPageRoute';
}

/// generated route for
/// [_i4.LiveGamesPage]
class LiveGamesPageRoute extends _i12.PageRouteInfo<void> {
  const LiveGamesPageRoute()
      : super(LiveGamesPageRoute.name, path: '/LiveGames');

  static const String name = 'LiveGamesPageRoute';
}

/// generated route for
/// [_i5.FinishedGamesPage]
class FinishedGamesPageRoute extends _i12.PageRouteInfo<void> {
  const FinishedGamesPageRoute()
      : super(FinishedGamesPageRoute.name, path: '/FinishedGames');

  static const String name = 'FinishedGamesPageRoute';
}

/// generated route for
/// [_i6.ProfilePage]
class ProfilePageRoute extends _i12.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({_i13.Key? key, required String uid})
      : super(ProfilePageRoute.name,
            path: '/Profile/:uid',
            args: ProfilePageRouteArgs(key: key, uid: uid),
            rawPathParams: {'uid': uid});

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({this.key, required this.uid});

  final _i13.Key? key;

  final String uid;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [_i7.EditGamePage]
class EditGamePageRoute extends _i12.PageRouteInfo<EditGamePageRouteArgs> {
  EditGamePageRoute(
      {_i13.Key? key, required String gameID, _i14.Game? initialData})
      : super(EditGamePageRoute.name,
            path: '/Edit/:gameID',
            args: EditGamePageRouteArgs(
                key: key, gameID: gameID, initialData: initialData),
            rawPathParams: {'gameID': gameID});

  static const String name = 'EditGamePageRoute';
}

class EditGamePageRouteArgs {
  const EditGamePageRouteArgs(
      {this.key, required this.gameID, this.initialData});

  final _i13.Key? key;

  final String gameID;

  final _i14.Game? initialData;

  @override
  String toString() {
    return 'EditGamePageRouteArgs{key: $key, gameID: $gameID, initialData: $initialData}';
  }
}

/// generated route for
/// [_i8.GamePage]
class GamePageRoute extends _i12.PageRouteInfo<GamePageRouteArgs> {
  GamePageRoute(
      {_i13.Key? key,
      required String gameID,
      List<_i12.PageRouteInfo>? children})
      : super(GamePageRoute.name,
            path: '/Game/:gameID',
            args: GamePageRouteArgs(key: key, gameID: gameID),
            rawPathParams: {'gameID': gameID},
            initialChildren: children);

  static const String name = 'GamePageRoute';
}

class GamePageRouteArgs {
  const GamePageRouteArgs({this.key, required this.gameID});

  final _i13.Key? key;

  final String gameID;

  @override
  String toString() {
    return 'GamePageRouteArgs{key: $key, gameID: $gameID}';
  }
}

/// generated route for
/// [_i9.MapPage]
class MapPageRoute extends _i12.PageRouteInfo<void> {
  const MapPageRoute() : super(MapPageRoute.name, path: '');

  static const String name = 'MapPageRoute';
}

/// generated route for
/// [_i10.ChatPage]
class ChatPageRoute extends _i12.PageRouteInfo<void> {
  const ChatPageRoute() : super(ChatPageRoute.name, path: 'Chat');

  static const String name = 'ChatPageRoute';
}

/// generated route for
/// [_i11.OrdersPage]
class OrdersPageRoute extends _i12.PageRouteInfo<void> {
  const OrdersPageRoute() : super(OrdersPageRoute.name, path: 'Orders');

  static const String name = 'OrdersPageRoute';
}
