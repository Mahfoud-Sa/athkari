import 'package:athkari/app/features/home/data/model/daily.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/usecase/check_updates_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/fetch_daily_wered_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/get_latest_apk_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit_status.dart';
import 'package:athkari/app/features/home/presentation/cubit/drawer_cubit_status.dart';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerCubit extends Cubit<DrawerCubitState> {
  final CheckUpdatesUsecase _checkUpdatesUsecase;
  final GetLatestRelease _getLatestAPKUsecase;
  //List<CategoryEntity> categoriesList = [];
  String? appVersion ;

  DrawerCubit(this._checkUpdatesUsecase, this._getLatestAPKUsecase) : super(DrawerCubitState()) {
    checkVersion();
  }
    void checkUpdate() async {
      emit(CheckUpdatesState());
      try {
        final updateAvailable = await _checkUpdatesUsecase();
        if (updateAvailable) {
        final apkLink=await _getLatestAPKUsecase(params: '1.2.7');
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
}
