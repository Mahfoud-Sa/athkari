import 'dart:io';

import 'package:athkari/app/features/home/data/datasources/release_remote_datasources.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_category_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogory_details_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/delete_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/done_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/update_daily_wered_repetation_usecase%20copy.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/add_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/delete_esnad_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/get_all_esnad_usecase.dart';
import 'package:athkari/app/features/esnaad/domain/usecase/update_esnade_usecase.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources_imp.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';
import 'package:athkari/app/features/home/data/repository/releases_repository_imp.dart';
import 'package:athkari/app/features/home/domain/repository/home_repository.dart';
import 'package:athkari/app/features/home/domain/repository/releases_repository.dart';
import 'package:athkari/app/features/home/domain/usecase/check_updates_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/fetch_daily_wered_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/get_latest_apk_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/drawer_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/today_dekhar_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

String applicationLanguage = 'en';

final getIt = GetIt.instance;
bool showOnBordingPages = true;
Future<void> initializationContainer() async {
//Local Storage
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  applicationLanguage = localStorage.getString("applicationLanguage") ?? 'en';
  showOnBordingPages = localStorage.getBool('showOnBordingPages') ?? true;

//Database
// if (!Platform.isAndroid) {
//  databaseFactory = databaseFactoryFfi; // Android-specific code
// }
  final appDataBaseServices = AppDataBaseServices();
  await appDataBaseServices.db;
  final gitHubApiService =
      ReleaseRemoteDataSorcesImp(githubToken: "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");
  getIt.registerSingleton<ReleaseRemoteDataSorcesImp>(gitHubApiService);
  getIt.registerSingleton<AppDataBaseServices>(appDataBaseServices);
  // appDataBaseServices.categoryDao.seedCategory();
//  appDataBaseServices.adhkaiDao.seedAdhkars();
  // State Managment
  getIt.registerFactory<HomepageCubit>(() => HomepageCubit(getIt()));
  getIt.registerFactory<DrawerCubit>(() => DrawerCubit(getIt(),getIt()));

  getIt.registerFactory<TodayDekharCubit>(() => TodayDekharCubit());
  getIt.registerFactory<DailyWereCubit>(
      () => DailyWereCubit(getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(
      getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<EsnadsCubit>(
      () => EsnadsCubit(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<DailyWeredCubit_>(() => DailyWeredCubit_(getIt()));
  // repositories
  getIt.registerSingleton<DhkarRepositoryImpl>(DhkarRepositoryImpl(getIt()));
  getIt
      .registerSingleton<CategoryRepositoryImp>(CategoryRepositoryImp(getIt()));
  getIt.registerSingleton<EsnadRepositoryImp>(EsnadRepositoryImp(getIt()));
  getIt.registerSingleton<DailyWeredRepositoryImpl>(
      DailyWeredRepositoryImpl(getIt()));
  getIt.registerSingleton<HomeRepositoryImp>(
      HomeRepositoryImp(getIt(), getIt()));
      getIt.registerSingleton<ReleaseRepositoryImp>(
      ReleaseRepositoryImp());

  // use cases
  //daily use case
  getIt.registerSingleton<GetDailyWereUseCase>(GetDailyWereUseCase(getIt()));
  getIt.registerSingleton<AddDhakerUseCase>(AddDhakerUseCase(getIt()));
  getIt
      .registerSingleton<DoneDailyWeredUsecase>(DoneDailyWeredUsecase(getIt()));
  getIt.registerSingleton<UpdateDailyWeredRepetationUsecase>(
      UpdateDailyWeredRepetationUsecase(getIt()));
  getIt.registerSingleton<DeleteDailyWeredUsecase>(
      DeleteDailyWeredUsecase(getIt()));
  getIt.registerSingleton<FetchDailyWeredUsecase>(
      FetchDailyWeredUsecase(getIt()));

  //category use case
  getIt.registerSingleton<GetCatogoriesUseCase>(GetCatogoriesUseCase(getIt()));
  getIt.registerSingleton<GetCatogoryDetailsUseCase>(
      GetCatogoryDetailsUseCase(getIt()));
  getIt.registerSingleton<AddCatogoriesUseCase>(AddCatogoriesUseCase(getIt()));
  getIt.registerSingleton<UpdateCatogoriesUseCase>(
      UpdateCatogoriesUseCase(getIt()));
  getIt.registerSingleton<DeleteCatogoriesUseCase>(
      DeleteCatogoriesUseCase(getIt()));
  getIt.registerSingleton<AddDekharWithEsnadUsecase>(
      AddDekharWithEsnadUsecase(getIt()));

  //Esnads use cases
  getIt.registerSingleton<GetAllEsnadUseCase>(GetAllEsnadUseCase(getIt()));
  getIt.registerSingleton<AddEsnadeUsecase>(AddEsnadeUsecase(getIt()));
  getIt.registerSingleton<UpdateEsnadeUsecase>(UpdateEsnadeUsecase(getIt()));
  getIt.registerSingleton<DeleteEsnadeUsecase>(DeleteEsnadeUsecase(getIt()));

  //Home usecase
 getIt.registerSingleton<CheckUpdatesUsecase>(CheckUpdatesUsecase(getIt()));
 getIt.registerSingleton<GetLatestRelease>(GetLatestRelease(getIt()));
}
