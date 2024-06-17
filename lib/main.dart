import 'package:athkari/app/config/routes/routes.dart';
import 'package:athkari/app/config/thems/light_thems.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializationContainer();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Athkari', routerConfig: AppRoutes.routers, theme: lightTheme);
  }
}
