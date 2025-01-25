import 'package:athkari/app/core/app_database.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/repository/esnads_repository.dart';

class EsnadRepositoryImp implements EsnadRepository {
  final AppDataBaseServices _appDataBaseServices;

  EsnadRepositoryImp(this._appDataBaseServices);

  @override
  Future<int> addEsnad(EsnadEntity esnad) async {
    return await _appDataBaseServices.esnadDao
        .InsertEsnad(EsnadModel(name: esnad.name));
  }

  @override
  Future<int> updateEsnad(EsnadEntity esnad) async {
    return await _appDataBaseServices.esnadDao
        .UpdateEsnad(esnad.id!, EsnadModel(name: esnad.name));
  }

  @override
  Future<List<EsnadEntity>> getAllEsnads() async {
    return await _appDataBaseServices.esnadDao.getAllEsnads();
  }

  @override
  Future<int> deleteEsnad(int id) async {
    return await _appDataBaseServices.esnadDao.deleteEsnad(id);
  }
}
