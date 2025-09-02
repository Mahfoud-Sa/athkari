import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/data/repository/home_repository_imp.dart';

class ResetDatabaseUsecase implements UseCase<void, EsnadEntity> {
  final HomeRepositoryImp _homeRepositoryImp;
  ResetDatabaseUsecase(this._homeRepositoryImp);
  @override
  Future<bool> call({EsnadEntity? params}) async {
    return await _homeRepositoryImp.resetDatabase();
  }
}
