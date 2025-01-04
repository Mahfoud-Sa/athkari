import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/domain/repository/dhkar_repository.dart';

class GetDailyWereUseCase implements UseCase {
  final DhkarRepository _dhkarRepository;
  GetDailyWereUseCase(this._dhkarRepository);
  @override
  Future call({params}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
