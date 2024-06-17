import 'package:athkari/app/features/home/presentation/pages/home_page.dart';
import 'package:athkari/app/features/on_bording/presentation/pages/on_bording.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter routers = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (BuildContext, state) {
            if (!showOnBordingPages) {
              return HomePage();
            } else {
              return Onbording();
            }
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'homepage',
              builder: (BuildContext, state) {
                return Onbording();
              },
            )
          ])
    ],
  );

  // static Widget buildRoute (BuildContext, state) {
  //           return Onbording();
  //         }
}
