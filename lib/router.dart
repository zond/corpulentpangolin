import 'package:auto_route/annotations.dart';

import 'start.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: Start, initial: true),
  ],
)
class $AppRouter {}
