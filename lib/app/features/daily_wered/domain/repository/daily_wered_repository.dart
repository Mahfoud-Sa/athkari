import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

abstract class DailyWeredRepository {
  Future<List<DailyWeredModel>> getAllDailyWereds();
  Future<void> doneDailyWered(int id);
  Future<void> updateDailyWeredRepertation(int id, int repetation);
  Future<int> deleteDailyWered(int id);
  Future<int> addDhkar(int dekharId,int repetitions);
  // Future<int> addDhkar(
  //     String dheer, int repetitions, int esnaad, EsnadEntity esnad);
  // Future<int> addDhkarWithCategory(int categoryId, DhkarEntity dhkar);
  // Future<void> dailyDhkarProgress();
  // Future<int> updateDhkar(DhkarEntity dhkar, EsnadEntity esnad);
  // Future<int> deleteDhkar(DhkarEntity dhkar);
  // Future<int> totalDeker();
}
