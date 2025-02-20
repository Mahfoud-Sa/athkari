import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

abstract class EsnadRepository {
  Future<List<EsnadEntity>> getAllEsnads();
  Future<List<EsnadModel>> getAllEsnadsWithAdkars();
  Future<int> updateEsnad(EsnadEntity esnad);
  Future<int> addEsnad(EsnadEntity esnad);

  Future<int> deleteEsnad(int id);
}
