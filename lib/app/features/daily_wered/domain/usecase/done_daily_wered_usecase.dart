import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/usecase/get_daily_wered.dart';

class DoneDailyWeredUsecase implements UseCase<void, int> {
  final DailyWeredRepositoryImpl _dailyWeredRepositoryImpl;
  DoneDailyWeredUsecase(this._dailyWeredRepositoryImpl);
  @override
  Future<int> call({int? params}) async {
    _dailyWeredRepositoryImpl.d
  }
}
