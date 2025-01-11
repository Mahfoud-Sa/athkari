import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';

class GetDailyWereUseCase implements UseCase {
  final DhkarRepositoryImpl _dhkarRepository;
  GetDailyWereUseCase(this._dhkarRepository);
  @override
  Future<List<Map<String, dynamic>>> call({params}) async {
    // TODO: implement call
    return await _dhkarRepository.getAllDhkars();
  }
}
