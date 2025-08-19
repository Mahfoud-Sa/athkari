import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class DhkarRepositoryImpl implements DhkarRepository {
  final AppDataBaseServices _appDataBaseServices;

  DhkarRepositoryImpl(this._appDataBaseServices);

  @override
  Future<List<DhkarModel>> getAllDhkars() async {
    var temp = await _appDataBaseServices.adhkaiDao.getAllAdhkai();

    return temp;
  }

  @override
  Future<int> addDhkar(
      String dheer, int repetitions, int esnaad, EsnadEntity esnad) {
    //return _appDataBaseServices.adhkaiDao.Insert(dheer, esnaad);
    // TODO: implement updateDhkar
    throw UnimplementedError();
  }

  @override
  Future<int> totalDeker() {
    return _appDataBaseServices.adhkaiDao.getTotal();
  }

  // @override
  // Future<int> updateDhkar(DhkarEntity dhkar,EsnadEntity esnad) async {
  //   // TODO: implement updateDhkar
  //   return await _appDataBaseServices.adhkaiDao.Update(dhkar);
  // }

  @override
  Future<bool> deleteDhkar(int id) {
    // TODO: implement deleteDhkar
     return _appDataBaseServices.adhkaiDao.Delete(id);
  }

  @override
  Future<int> updateDhkar(int categoryId, DhkarEntity dhkar) async{
     var temp = await _appDataBaseServices.adhkaiDao
        .Update(categoryId, DhkarModel.fromEntity(dhkar));
    print(temp);
    return temp;
  }

  @override
  Future<int> addDhkarWithCategory(int categoryId, DhkarEntity dhkar) async {
    var temp = await _appDataBaseServices.adhkaiDao
        .InsertWitnCategory(categoryId, DhkarModel.fromEntity(dhkar));
    print(temp);
    return temp;
  }

  @override
  Future<void> dailyDhkarProgress() {
    // TODO: implement dailyDhkarProgress
    throw UnimplementedError();
  }
}
