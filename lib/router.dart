import 'package:auto_route/annotations.dart';

import 'start.dart';
import 'create_game.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: Start, initial: true),
    AutoRoute(page: CreateGame),
  ],
)
class $AppRouter {}
