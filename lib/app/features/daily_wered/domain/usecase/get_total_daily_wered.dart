import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';

class GetTotalDailyWereUseCase implements UseCase {
  final DhkarRepositoryImpl _dhkarRepository;
  GetTotalDailyWereUseCase(this._dhkarRepository);
  @override
  Future<int> call({params}) async {
    return await _dhkarRepository.totalDekers();
  }
}
