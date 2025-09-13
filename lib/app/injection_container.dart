import 'dart:io';

import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_dekhair_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_dekhar_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit.dart';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/repository/category_repository.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_dekhar_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_to_dailywered_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogory_details_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/daily_wered_repository.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/add_dhaker_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/delete_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/done_daily_wered_usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/update_daily_wered_repetation_usecase%20copy.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/repository/esnads_repository.dart';
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
import 'package:athkari/app/features/home/domain/usecase/reset_database_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/app_update_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/today_dekhar_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

String applicationLanguage = 'en';

final getIt = GetIt.instance;
bool showOnBordingPages = true;

Future<void> initializationContainer() async {
  // Local Storage
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  applicationLanguage = localStorage.getString("applicationLanguage") ?? 'en';
  showOnBordingPages = localStorage.getBool('showOnBordingPages') ?? true;

  // Database
  final appDataBaseServices = AppDataBaseServices();
  await appDataBaseServices.db;

  // Remote Data Sources
  final gitHubApiService =
      ReleaseRemoteDataSorcesImp(githubToken: "your_github_token");
  getIt.registerSingleton<ReleaseRemoteDataSorcesImp>(gitHubApiService);
  getIt.registerSingleton<AppDataBaseServices>(appDataBaseServices);

  // State Management (Cubits)
  getIt.registerFactory<HomepageCubit>(() => HomepageCubit(getIt()));
  getIt.registerFactory<AppUpdateCubit>(() => AppUpdateCubit(getIt(), getIt()));
  getIt.registerFactory<ResetCubit>(() => ResetCubit(getIt()));
  getIt.registerFactory<TodayDekharCubit>(() => TodayDekharCubit());
  getIt.registerFactory<DailyWereCubit>(
      () => DailyWereCubit(getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<CategoryDetailsCubit>(
      () => CategoryDetailsCubit(getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<CategoryCubit>(
      () => CategoryCubit(getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<EsnadsCubit>(() => EsnadsCubit(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<DailyWeredProgressCubit>(() => DailyWeredProgressCubit(getIt()));

  // Repositories (interface -> implementation)
  getIt.registerSingleton<DhkarRepositoryImpl>(DhkarRepositoryImpl(getIt()));
  getIt.registerSingleton<CategoryRepositoryImp>(CategoryRepositoryImp(getIt()));
  getIt.registerSingleton<EsnadsRepository>(EsnadsRepositoryImp(getIt()));
  getIt.registerSingleton<DailyWeredRepositoryImpl>(DailyWeredRepositoryImpl(getIt()));
  getIt.registerSingleton<HomeRepositoryImp>(HomeRepositoryImp(getIt(), getIt()));
  getIt.registerSingleton<ReleaseRepositoryImp>(ReleaseRepositoryImp());

  // Use Cases
  // Daily
  getIt.registerSingleton<GetDailyWereUseCase>(GetDailyWereUseCase(getIt()));
  getIt.registerSingleton<AddDhakerUseCase>(AddDhakerUseCase(getIt()));
  getIt.registerSingleton<DoneDailyWeredUsecase>(DoneDailyWeredUsecase(getIt()));
  getIt.registerSingleton<UpdateDailyWeredRepetationUsecase>(UpdateDailyWeredRepetationUsecase(getIt()));
  getIt.registerSingleton<DeleteDailyWeredUsecase>(DeleteDailyWeredUsecase(getIt()));
  getIt.registerSingleton<FetchDailyWeredUsecase>(FetchDailyWeredUsecase(getIt()));

  // Category
  getIt.registerSingleton<GetCatogoriesUseCase>(GetCatogoriesUseCase(getIt()));
  getIt.registerSingleton<GetCatogoryDetailsUseCase>(GetCatogoryDetailsUseCase(getIt()));
  getIt.registerSingleton<AddCatogoriesUseCase>(AddCatogoriesUseCase(getIt()));
  getIt.registerSingleton<UpdateCatogoriesUseCase>(UpdateCatogoriesUseCase(getIt()));
  getIt.registerSingleton<DeleteCatogoriesUseCase>(DeleteCatogoriesUseCase(getIt()));
  getIt.registerSingleton<AddDekharWithEsnadUsecase>(AddDekharWithEsnadUsecase(getIt()));
  getIt.registerSingleton<UpdateDekharWithEsnadUsecase>(UpdateDekharWithEsnadUsecase(getIt()));
  getIt.registerSingleton<AddToDailyweredUsecase>(AddToDailyweredUsecase(getIt()));
  getIt.registerSingleton<DeleteDekharUseCase>(DeleteDekharUseCase(getIt()));

  // Esnads
  getIt.registerSingleton<GetAllEsnadUseCase>(GetAllEsnadUseCase(getIt()));
  getIt.registerSingleton<AddEsnadeUsecase>(AddEsnadeUsecase(getIt()));
  getIt.registerSingleton<UpdateEsnadeUsecase>(UpdateEsnadeUsecase(getIt()));
  getIt.registerSingleton<DeleteEsnadeUsecase>(DeleteEsnadeUsecase(getIt()));

  // Home
  getIt.registerSingleton<CheckUpdatesUsecase>(CheckUpdatesUsecase(getIt()));
  getIt.registerSingleton<GetLatestRelease>(GetLatestRelease(getIt()));
  getIt.registerSingleton<ResetDatabaseUsecase>(ResetDatabaseUsecase(getIt()));
}
