import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:athkari/app/features/daily_wered/data/repository/daily_wered_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/daily_wered_entity.dart';

class GetDailyWereUseCase implements UseCase {
  final DhkarRepositoryImpl _dekharRepository;
  GetDailyWereUseCase(this._dekharRepository);
  @override
  Future<List<DailyWeredModel>> call({params}) async {
    return await _dekharRepository.getAllDailyWereds();
  }
}
