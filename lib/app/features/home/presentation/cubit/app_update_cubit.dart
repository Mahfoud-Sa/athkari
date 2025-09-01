import 'package:athkari/app/features/home/domain/usecase/check_updates_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/get_latest_apk_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/app_update_drawer_cubit_status.dart';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdateCubit extends Cubit<AppUpdateCubitState> {
  final CheckUpdatesUsecase _checkUpdatesUsecase;
  final GetLatestRelease _getLatestAPKUsecase;
  String? appVersion;

  AppUpdateCubit(this._checkUpdatesUsecase, this._getLatestAPKUsecase) 
      : super(AppUpdateCubitState()) {
    _initializeVersion();
  }

  Future<void> _initializeVersion() async {
    try {
      final _packageInfo = await PackageInfo.fromPlatform();
      appVersion = _packageInfo.version;
    } catch (e) {
      emit(CheckUpdateErrorState('فشل في الحصول على إصدار التطبيق'));
    }
  }

  Future<void> checkUpdate() async {
    emit(UpdateWaitingState());
     await Future.delayed(const Duration(seconds: 5));
    if (appVersion == null) {
      await _initializeVersion();
      if (appVersion == null) {
        
        
        emit(CheckUpdateErrorState('لا يمكن التحقق من التحديثات'));
        return;
      }
    }
    
    emit(CheckUpdatesState());
    try {
      final updateAvailable = await _checkUpdatesUsecase(params: appVersion);
      if (updateAvailable) {
        final apkLink = await _getLatestAPKUsecase();
        emit(UpdateAvailableState(apkLink));
      } else {
        emit(NoUpdateState('لا يوجد تحديثات متاحة'));
      }
    } catch (e) {
      emit(CheckUpdateErrorState('فشل في التحقق من التحديثات'));
    }
  }
}