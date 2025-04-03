import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';

class UpdateDailyWeredRepetationUsecase implements UseCase<void, int> {
  final DailyWeredRepositoryImpl _dailyWeredRepository;
  UpdateDailyWeredRepetationUsecase(this._dailyWeredRepository);
  @override
  Future<void> call({int? params, int? repatation}) async {
    _dailyWeredRepository.updateDailyWeredRepertation(params!, repatation!);
  }
}
