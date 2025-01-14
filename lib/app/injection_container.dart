import 'package:athkari/app/features/daily_wered/data/datasources/app_database.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_total_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/local_daily_were_cubit_cubit.dart';
import 'package:get_it/get_it.dart';
//import 'package:news_app/app/core/resources/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

String applicationLanguage = 'en';

final getIt = GetIt.instance;
bool showOnBordingPages = true;
Future<void> initializationContainer() async {
//Local Storage
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  applicationLanguage = localStorage.getString("applicationLanguage") ?? 'en';
  showOnBordingPages = localStorage.getBool('showOnBordingPages') ?? true;

//Database
  final _appDataBaseServices = await AppDataBaseServices();
  await _appDataBaseServices.db;
  getIt.registerSingleton<AppDataBaseServices>(_appDataBaseServices);
  var _AppDataBaseServices = await getIt.get<AppDataBaseServices>();

  // State Managment
  getIt.registerFactory<LocalDailyWereCubitCubit>(
      () => LocalDailyWereCubitCubit(getIt(), getIt()));

  // repositories
  getIt.registerSingleton<DhkarRepositoryImpl>(DhkarRepositoryImpl(getIt()));

// use cases
  getIt.registerSingleton<GetDailyWereUseCase>(GetDailyWereUseCase(getIt()));
  getIt.registerSingleton<AddDhakerUseCase>(AddDhakerUseCase(getIt()));
  getIt.registerSingleton<GetTotalDailyWereUseCase>(
      GetTotalDailyWereUseCase(getIt()));
}
