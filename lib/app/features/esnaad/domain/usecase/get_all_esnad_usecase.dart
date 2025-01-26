import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';

class GetAllEsnadUseCase implements UseCase {
  final EsnadRepositoryImp _esnadRepositoryImp;
  GetAllEsnadUseCase(this._esnadRepositoryImp);
  @override
  Future<List<EsnadEntity>> call({params}) {
    return _esnadRepositoryImp.getAllEsnads();
  }
}
