import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class UpdateEsnadeUsecase implements UseCase<void, EsnadEntity> {
  final EsnadRepositoryImp _esnadRepositoryImp;
  UpdateEsnadeUsecase(this._esnadRepositoryImp);
  @override
  Future<int> call({EsnadEntity? params}) async {
    return await _esnadRepositoryImp
        .updateEsnad(EsnadEntity(id: params!.id, name: params!.name));
  }
}
