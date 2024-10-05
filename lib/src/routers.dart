import 'package:go_router/go_router.dart';
import 'package:compairifuel/src/global/ui/screens/map_screen.dart';
import 'package:compairifuel/src/global/ui/screens/user_manual.dart';

enum AppRoute {
  map('/'),
  manual('/manual');

  const AppRoute(this.path);

  final String path;
}

GoRouter goRouter() {
  return GoRouter(initialLocation: AppRoute.manual.path, routes: [
    GoRoute(
        path: AppRoute.map.path,
        builder: (context, state) {
          return const MapScreen();
        }),
    GoRoute(
        path: AppRoute.manual.path,
        builder: (context, state) {
          return UserManualScreen(
            onMap: () => context.go(AppRoute.map.path),
          );
        })
  ]);
}
