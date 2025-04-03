import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_category_with_esnade_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/add_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/delete_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogories_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/get_catogory_details_usecase.dart';
import 'package:athkari/app/features/categories/domain/usecase/update_catogories_usecase.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/core/app_database.dart';
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
import 'package:athkari/app/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:get_it/get_it.dart';
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
  //_AppDataBaseServices.categoryDao.seedCategory();
  // _AppDataBaseServices.esnadDao.seedEsnads();
  //await _AppDataBaseServices.adhkaiDao.seedEsnads();
  await _AppDataBaseServices.dailyWeredDao.seedDailyWered();
  // State Managment
  getIt.registerFactory<DailyWereCubit>(
      () => DailyWereCubit(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(
      getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<EsnadsCubit>(
      () => EsnadsCubit(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory<HomepageCubit>(() => HomepageCubit(getIt()));

  // repositories
  getIt.registerSingleton<DhkarRepositoryImpl>(DhkarRepositoryImpl(getIt()));
  getIt
      .registerSingleton<CategoryRepositoryImp>(CategoryRepositoryImp(getIt()));
  getIt.registerSingleton<EsnadRepositoryImp>(EsnadRepositoryImp(getIt()));
  getIt.registerSingleton<DailyWeredRepositoryImpl>(
      DailyWeredRepositoryImpl(getIt()));

  // use cases
  //daily use case
  getIt.registerSingleton<GetDailyWereUseCase>(GetDailyWereUseCase(getIt()));
  getIt.registerSingleton<AddDhakerUseCase>(AddDhakerUseCase(getIt()));
  getIt
      .registerSingleton<DoneDailyWeredUsecase>(DoneDailyWeredUsecase(getIt()));
  getIt.registerSingleton<UpdateDailyWeredRepetationUsecase>(
      UpdateDailyWeredRepetationUsecase(getIt()));
  // getIt.registerSingleton<DeleteDailyWeredUsecase>(
  //     DeleteDailyWeredUsecase(getIt()));

  // getIt.registerSingleton<GetTotalDailyWereUseCase>(
  //     GetTotalDailyWereUseCase(getIt()));
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
}
