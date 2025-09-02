import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class HomeRepository {
  Future<bool> resetDatabase();
  Future<DailyWeredProgressEntity> getDailyWeredProgress();
  //Future<bool> resetDatabase();
  //Future<String?> getLatestApkUrl();
}
