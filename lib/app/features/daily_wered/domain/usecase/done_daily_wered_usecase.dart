import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';

class DoneDailyWeredUsecase implements UseCase<void, int> {
  final DhkarRepositoryImpl _dekharRepository;
  DoneDailyWeredUsecase(this._dekharRepository);
  @override
  Future<void> call({int? params}) async {
    _dekharRepository.doneDailyWered(params!);
  }
}
