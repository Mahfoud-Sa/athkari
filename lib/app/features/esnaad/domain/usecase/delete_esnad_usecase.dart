import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';

class DeleteEsnadeUsecase implements UseCase<void, int> {
  final EsnadRepositoryImp _esnadRepositoryImp;
  DeleteEsnadeUsecase(this._esnadRepositoryImp);
  @override
  Future<int> call({int? params}) async {
    return await _esnadRepositoryImp.deleteEsnad(params!);
  }
}
