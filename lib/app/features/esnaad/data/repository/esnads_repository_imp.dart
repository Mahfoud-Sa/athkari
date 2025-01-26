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
        .insertEsnad(EsnadModel.fromEntity(esnad));
  }

  @override
  Future<int> updateEsnad(EsnadEntity esnad) {
    return _appDataBaseServices.esnadDao
        .updateEsnad(esnad.id!, EsnadModel.fromEntity(esnad));
  }

  @override
  Future<List<EsnadModel>> getAllEsnads() async {
    return await _appDataBaseServices.esnadDao.getAllEsnads();
  }

  @override
  Future<int> deleteEsnad(int id) async {
    return await _appDataBaseServices.esnadDao.deleteEsnad(id);
  }
}
