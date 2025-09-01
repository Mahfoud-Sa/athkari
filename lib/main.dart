import 'dart:isolate';

import 'package:athkari/app/config/routes/routes.dart';
import 'package:athkari/app/config/thems/light_thems.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/app_update_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/today_dekhar_cubit.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // await Isolate.run(() => initializationContainer());

  await initializationContainer();
  runApp(

      //for testing purposes
      //  DevicePreview(
      //  enabled: !kReleaseMode,
      //builder: (context) =>
      MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => TodayDekharCubit()),
      BlocProvider(
          create: (_) =>
              DailyWereCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
              
              ),
      BlocProvider(
          create: (_) => CategoryCubit(
              getIt(), getIt(), getIt(), getIt(), getIt(),)),
               BlocProvider(
          create: (_) => CategoryDetailsCubit(
              getIt(), getIt(),getIt(),getIt(),getIt())),
      BlocProvider(
          create: (_) => EsnadsCubit(getIt(), getIt(), getIt(), getIt())),
      BlocProvider(create: (_) => HomepageCubit(getIt())),
      BlocProvider(
      create: (context) {
        final cubit = AppUpdateCubit(getIt(), getIt());
        cubit.checkUpdate();
        return cubit;
      },
    ),
      BlocProvider(create: (_) => DailyWeredProgressCubit(getIt())),//..initialize()),
      BlocProvider(create: (_) => ResetCubit()),
    ],
    child: App(),
    // ),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'أذكاري',
        routerConfig: AppRoutes.routers,
        theme: lightTheme);
  }
}
