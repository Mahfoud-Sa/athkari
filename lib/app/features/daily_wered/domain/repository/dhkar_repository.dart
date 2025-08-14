import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

abstract class DhkarRepository {
  Future<List<DhkarEntity>> getAllDhkars();
  Future<int> addDhkar(
      String dheer, int repetitions, int esnaad, EsnadEntity esnad);
  Future<int> addDhkarWithCategory(int categoryId, DhkarEntity dhkar);
  Future<void> dailyDhkarProgress();
  Future<int> updateDhkar(DhkarEntity dhkar, EsnadEntity esnad);
  Future<bool> deleteDhkar(int id);
  Future<int> totalDeker();
}
