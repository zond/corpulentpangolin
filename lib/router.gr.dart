// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'create_game.dart' as _i2;
import 'start.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    StartRoute.name: (routeData) {
      final args = routeData.argsAs<StartRouteArgs>(
          orElse: () => const StartRouteArgs());
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.Start(key: args.key));
    },
    CreateGameRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateGame());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(StartRoute.name, path: '/'),
        _i3.RouteConfig(CreateGameRoute.name, path: '/create-game')
      ];
}

/// generated route for [_i1.Start]
class StartRoute extends _i3.PageRouteInfo<StartRouteArgs> {
  StartRoute({_i4.Key? key})
      : super(name, path: '/', args: StartRouteArgs(key: key));

  static const String name = 'StartRoute';
}

class StartRouteArgs {
  const StartRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'StartRouteArgs{key: $key}';
  }
}

/// generated route for [_i2.CreateGame]
class CreateGameRoute extends _i3.PageRouteInfo<void> {
  const CreateGameRoute() : super(name, path: '/create-game');

  static const String name = 'CreateGameRoute';
}
