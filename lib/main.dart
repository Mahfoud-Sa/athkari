import 'package:athkari/app/config/routes/routes.dart';
import 'package:athkari/app/config/thems/light_thems.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_cubit.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializationContainer();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => LocalDailyWereCubitCubit()),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Athkari', routerConfig: AppRoutes.routers, theme: lightTheme);
  }
}
