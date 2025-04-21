import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';

abstract class HomeRepository {
  Future<int> resetDatabase(EsnadEntity esnad) ;
  Future<DailyWeredProgressEntity> getDailyWeredProgress();
  
}
