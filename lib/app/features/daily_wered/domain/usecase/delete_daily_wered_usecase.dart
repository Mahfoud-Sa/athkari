import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';

class DeleteDailyWeredUsecase implements UseCase<void, int> {
  final DhkarRepositoryImpl _dekharRepository;
  DeleteDailyWeredUsecase(this._dekharRepository);
  @override
  Future<void> call({int? params}) async {
    _dekharRepository.deleteDailyWered(params!);
  }
}
