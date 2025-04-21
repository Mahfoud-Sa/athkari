import 'package:athkari/app/core/app_database.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImp  implements HomeRepository{
   final AppDataBaseServices _appDataBaseServices;
   HomeRepositoryImp(this._appDataBaseServices);
  @override
  Future<DailyWeredProgressEntity> getDailyWeredProgress() async{
   int totalWered= await _appDataBaseServices.dailyWeredDao.getTotalDailyWered();
   int compeletedWered= await  _appDataBaseServices.dailyWeredDao.getCompeletedDailyWered();

    return DailyWeredProgressEntity(totalWered: totalWered,compeletedWered: compeletedWered);
  }

  @override
  Future<int> resetDatabase(EsnadEntity esnad) {
    // TODO: implement resetDatabase
    throw UnimplementedError();
  }
}