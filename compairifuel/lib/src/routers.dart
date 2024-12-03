import 'package:compairifuel/src/global/ui/screens/gasstation_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:compairifuel/src/global/ui/screens/map_screen.dart';
import 'package:compairifuel/src/global/ui/screens/user_manual.dart';

enum AppRoute {
  map('/', {"gasstation": AppRoute._mapGasstation}),
  _mapGasstation('/gasstation/:id'),

  manual('/manual'),
  ;

  const AppRoute(this.path, [this.routes]);

  final String path;
  final Map<String, AppRoute>? routes;
}

GoRouter goRouter() {
  return GoRouter(
    initialLocation: AppRoute.manual.path,
    routes: [
      GoRoute(
        path: AppRoute.map.path,
        builder: (context, state) {
          return const MapScreen();
        },
        routes: [
          GoRoute(
            path: AppRoute.map.routes!['gasstation']!.path,
            builder: (context, state) {
              return GasstationDetailScreen(
                id: state.pathParameters['id']!,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.manual.path,
        builder: (context, state) {
          return UserManualScreen(
            onMap: () => context.go(AppRoute.map.path),
          );
        },
      ),
    ],
  );
}
