import 'package:athkari/app/features/home/data/model/daily.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/usecase/check_updates_usecase.dart';
import 'package:athkari/app/features/home/domain/usecase/fetch_daily_wered_usecase.dart';
import 'package:athkari/app/features/home/presentation/cubit/daily_wered_cubit_status.dart';
import 'package:athkari/app/features/home/presentation/cubit/drawer_cubit_status.dart';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerCubit extends Cubit<DrawerCubitState> {
  final CheckUpdatesUsecase _checkUpdatesUsecase;
  //List<CategoryEntity> categoriesList = [];
  String appVersion = "V1.2.7";

  DrawerCubit(this._checkUpdatesUsecase) : super(InitialDrawerPageState()) {
    checkUpdate();
  }

  checkUpdate() async {
    emit(CheckUpdatesState());
    // if (true) {
    //   appVersion = "V2.0.0";
    //   emit(UpdateAvailableState(appVersion));
    //   //UpdateAvailableState();
    // } else {
    //   emit((NoUpdateState("لا يوجد تحديثات متاحة")));
    // }
  }

  checkVersion() async {
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    appVersion = _packageInfo.version;
  }
}
