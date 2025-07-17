import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/repository/home_repository.dart';

class CheckUpdatesUsecase implements UseCase<void, void> {
  @override
  Future<void> call({void params}) {
    // TODO: implement call
    throw UnimplementedError();
  }
  //final  _homeRepository;
  // CheckUpdatesUsecase();
  // @override
  // Future<DailyWeredProgressEntity> call({params}) async {
  //  // return await _homeRepository.getDailyWeredProgress();
  // }
}
