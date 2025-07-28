import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources_imp.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/repository/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeRepositoryImp implements HomeRepository {
  final AppDataBaseServices _appDataBaseServices;
  final ReleaseRemoteDataSorcesImp _gitHubApiService;
  HomeRepositoryImp(this._appDataBaseServices, this._gitHubApiService);
  @override
  Future<DailyWeredProgressEntity> getDailyWeredProgress() async {
    int totalWered =
        await _appDataBaseServices.dailyWeredDao.getTotalDailyWered();
    int compeletedWered =
        await _appDataBaseServices.dailyWeredDao.getCompeletedDailyWered();

    return DailyWeredProgressEntity(
        totalWered: totalWered, compeletedWered: compeletedWered);
  }

  @override
  Future<int> resetDatabase(EsnadEntity esnad) {
    // TODO: implement resetDatabase
    throw UnimplementedError();
  }

 
}
