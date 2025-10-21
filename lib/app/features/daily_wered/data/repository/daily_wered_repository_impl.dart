import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/daily_wered_repository.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class DailyWeredRepositoryImpl {
  //implements DailyWeredRepository
  final AppDataBaseServices _appDataBaseServices;

  DailyWeredRepositoryImpl(this._appDataBaseServices);

  Future<List<DailyWeredModel>> getAllDailyWered() async {
    // var temp = await _appDataBaseServices.dailyWeredDao.getAllAdhkai();
    var temp = await _appDataBaseServices.adhkaiDao.getAllDailyWereds();

    return temp;
  }

  @override
  Future<List<DailyWeredModel>> getAllDailyWereds() async {
    // var temp = await _appDataBaseServices.dailyWeredDao.getAllAdhkai();
    await Future.delayed(Duration(seconds: 1));
    // temp =
    //  var temp = await _appDataBaseServices.adhkaiDao.getAllDailyWereds();

    return <DailyWeredModel>[];
    ;
  }

  @override
  Future<void> doneDailyWered(int id) async {
    //  await _appDataBaseServices.dailyWeredDao.doneDailyWered(id);
  }

  @override
  Future<void> updateDailyWeredRepertation(int id, int repetation) async {
    //   await _appDataBaseServices.dailyWeredDao.updateRepetation(id, repetation);
  }

  @override
  Future<int> deleteDailyWered(int id) async {
    return 1;
    // return await _appDataBaseServices.dailyWeredDao.deleteDailyWered(id);
  }

  // @override
  // Future<List<DhkarModel>> getAllDhkars() async {
  //   var temp = await _appDataBaseServices.adhkaiDao.getAllAdhkai();

  //   return temp;
  // }

  @override
  Future<int> addDhkar(int dekharId, int repetitions) async {
    //return _appDataBaseServices.adhkaiDao.Insert(dheer, esnaad);

    var temp =
        await _appDataBaseServices.adhkaiDao.addToDaily(dekharId, repetitions);
    print(temp);
    return (temp);
  }

  // @override
  // Future<int> totalDeker() {
  //   return _appDataBaseServices.adhkaiDao.getTotal();
  // }

  // // @override
  // // Future<int> updateDhkar(DhkarEntity dhkar,EsnadEntity esnad) async {
  // //   // TODO: implement updateDhkar
  // //   return await _appDataBaseServices.adhkaiDao.Update(dhkar);
  // // }

  // @override
  // Future<int> deleteDhkar(DhkarEntity dhkar) {
  //   // TODO: implement deleteDhkar
  //   throw UnimplementedError();
  // }

  // @override
  // Future<int> updateDhkar(DhkarEntity dhkar, EsnadEntity esnad) {
  //   // TODO: implement updateDhkar
  //   throw UnimplementedError();
  // }

  // @override
  // Future<int> addDhkarWithCategory(int categoryId, DhkarEntity dhkar) async {
  //   var temp = await _appDataBaseServices.adhkaiDao
  //       .InsertWitnCategory(categoryId, DhkarModel.fromEntity(dhkar));
  //   print(temp);
  //   return temp;
  // }

  // @override
  // Future<void> dailyDhkarProgress() {
  //   // TODO: implement dailyDhkarProgress
  //   throw UnimplementedError();
  // }
}
