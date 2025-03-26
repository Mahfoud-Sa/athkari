import 'package:athkari/app/core/app_database.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/daily_wered_repository.dart';

class DailyWeredRepositoryImpl implements DailyWeredRepository {
  final AppDataBaseServices _appDataBaseServices;

  DailyWeredRepositoryImpl(this._appDataBaseServices);

  @override
  Future<List<DailyWeredModel>> getAllDailyWereds() async {
    var temp = await _appDataBaseServices.dailyWeredDao.getAllAdhkai();
    return temp;
  }

  @override
  Future<void> doneDailyWered() async {
    await _appDataBaseServices.dailyWeredDao.doneDailyWered();
  }

  // @override
  // Future<List<DhkarModel>> getAllDhkars() async {
  //   var temp = await _appDataBaseServices.adhkaiDao.getAllAdhkai();

  //   return temp;
  // }

  // @override
  // Future<int> addDhkar(
  //     String dheer, int repetitions, int esnaad, EsnadEntity esnad) {
  //   //return _appDataBaseServices.adhkaiDao.Insert(dheer, esnaad);
  //   // TODO: implement updateDhkar
  //   throw UnimplementedError();
  // }

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
