import 'package:athkari/app/features/home/domain/usecase/check_updates_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/get_latest_apk_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/app_update_drawer_cubit_status.dart';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdateCubit extends Cubit<AppUpdateCubitState> {
  final CheckUpdatesUsecase _checkUpdatesUsecase;
  final GetLatestRelease _getLatestAPKUsecase;
  //List<CategoryEntity> categoriesList = [];
  String? appVersion ;

  AppUpdateCubit(this._checkUpdatesUsecase, this._getLatestAPKUsecase) : super(AppUpdateCubitState()) {
    checkVersion();
  }
    void checkUpdate() async {
      emit(CheckUpdatesState());
      try {
         if(appVersion==null){
            checkVersion();
          }
        final updateAvailable = await _checkUpdatesUsecase(params: appVersion);
        if (updateAvailable) {
         
        final apkLink=await _getLatestAPKUsecase();
        emit(UpdateAvailableState(apkLink));
        } else {
          emit(NoUpdateState('لا يوجد تحديثات متاحة'));
        }
      } catch (e) {
        emit(CheckUpdateErrorState('فشل في التحقق من التحديثات'));
      }
    }
  checkVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    appVersion = _packageInfo.version;
  }

  toggleDarkMode(value){
return false;
  }
}
