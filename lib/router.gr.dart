// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'create_game.dart' as _i4;
import 'start.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.Start());
    },
    CreateGameRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.CreateGame());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartRoute.name, path: '/'),
        _i1.RouteConfig(CreateGameRoute.name, path: '/create-game')
      ];
}

class StartRoute extends _i1.PageRouteInfo<void> {
  const StartRoute() : super(name, path: '/');

  static const String name = 'StartRoute';
}

class CreateGameRoute extends _i1.PageRouteInfo<void> {
  const CreateGameRoute() : super(name, path: '/create-game');

  static const String name = 'CreateGameRoute';
}
