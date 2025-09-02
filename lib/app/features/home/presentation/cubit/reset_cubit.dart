import 'dart:math';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/home/domain/usecase/reset_database_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit_states.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetCubit extends Cubit<ResetCubitState> {
  final ResetDatabaseUsecase _resetDatabaseUsecase;
  
  ResetCubit(this._resetDatabaseUsecase) 
      : super(InitState()) {
    _initializeVersion();
  }

  Future<void> _initializeVersion() async {
    // try {
    //   final _packageInfo = await PackageInfo.fromPlatform();
    //   appVersion = _packageInfo.version;
    // } catch (e) {
    //   emit(CheckUpdateErrorState('فشل في الحصول على إصدار التطبيق'));
    // }
  }

  Future<void> clearAllTables() async {
    emit(WaitingState());
    //await Future.delayed(const Duration(seconds: 5));
    // getIt<AppDataBaseServices>().clearAllTables();
   var state=await _resetDatabaseUsecase.call();
    if(state){
      getIt<CategoryCubit>().fetchData();
      getIt<DailyWereCubit>().FetchData();
      getIt<EsnadsCubit>().fetchData();
      
      emit(DoneState());
    //emit(DoneState());
    }
    else{
      emit(ErrorState('فشل في إعادة ضبط قاعدة البيانات'));
    }}
    
//   //   emit(CheckUpdatesState());
//   //   try {
//   //     final updateAvailable = await _checkUpdatesUsecase(params: appVersion);
//   //     if (updateAvailable) {
//   //       final apkLink = await _getLatestAPKUsecase();
//   //       emit(UpdateAvailableState(apkLink));
//   //     } else {
//   //       emit(NoUpdateState('لا يوجد تحديثات متاحة'));
//   //     }
//   //   } catch (e) {
//   //     emit(CheckUpdateErrorState('فشل في التحقق من التحديثات'));
//   //   }
//   // }
}