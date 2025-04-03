import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';

class DeleteDailyWeredUsecase implements UseCase<void, int> {
  final DailyWeredRepositoryImpl _dailyWeredRepository;
  DeleteDailyWeredUsecase(this._dailyWeredRepository);
  @override
  Future<void> call({int? params}) async {
    _dailyWeredRepository.deleteDailyWered(params!);
  }
}
