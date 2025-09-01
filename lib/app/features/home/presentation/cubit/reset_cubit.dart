import 'dart:math';

import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit_states.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetCubit extends Cubit<ResetCubitState> {

  String? appVersion;

  ResetCubit() 
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
    await Future.delayed(const Duration(seconds: 5));
    emit(DoneState());
    //await getIt<AppDataBaseServices>().clearAllTables();
    }
    
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