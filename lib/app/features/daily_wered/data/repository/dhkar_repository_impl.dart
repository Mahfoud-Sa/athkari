import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
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
  Future<int> addDhkarTemp(
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
    return _appDataBaseServices.adhkaiDao.delete(id);
  }

  @override
  Future<int> updateDhkar(int categoryId, DhkarEntity dhkar) async {
    var temp = await _appDataBaseServices.adhkaiDao
        .update(categoryId, DhkarModel.fromEntity(dhkar));
    print(temp);
    return temp;
  }

  @override
  Future<int> addDhkarWithCategory(int categoryId, DhkarEntity dhkar) async {
    var temp = await _appDataBaseServices.adhkaiDao
        .insertWitnCategory(categoryId, DhkarModel.fromEntity(dhkar));
    print(temp);
    return temp;
  }

  @override
  Future<void> dailyDhkarProgress() {
    // TODO: implement dailyDhkarProgress
    throw UnimplementedError();
  }

  @override
  Future<int> addToDailyWered(int dekharId, int repetitions) async {
    /// this methos is changes the adkhar's daily were to be true,
    ///  so it will showin then in the dauily wered pages
    ///
    int responsive = await _appDataBaseServices.adhkaiDao
        .updateDailyWeredStatus(dekharId, true);
    await _appDataBaseServices.adhkaiDao
        .updateRepetation(dekharId, repetitions);

    return (responsive);
  }

  @override
  Future<int> deleteDailyWered(int id) {
    return _appDataBaseServices.adhkaiDao.updateDailyWeredStatus(id, false);
  }

  @override
  Future<void> doneDailyWered(int id) async {
    await _appDataBaseServices.adhkaiDao.doneDailyWered(id);
  }

  @override
  Future<List<DailyWeredModel>> getAllDailyWereds() {
    return _appDataBaseServices.adhkaiDao.getAllDailyWereds();
  }

  @override
  Future<void> updateDailyWeredRepertation(int id, int repetation) async {
    await _appDataBaseServices.adhkaiDao.updateRepetation(id, repetation);
  }

  @override
  Future<int> addDhkar(
      String dheer, int repetitions, int esnaad, EsnadEntity esnad) {
    // TODO: implement addDhkar
    throw UnimplementedError();
  }
}
