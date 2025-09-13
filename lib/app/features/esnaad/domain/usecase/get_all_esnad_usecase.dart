import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/esnaad/data/repository/esnads_repository_imp.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/domain/repository/esnads_repository.dart';

class GetAllEsnadUseCase {
  final EsnadsRepository repository;
  GetAllEsnadUseCase(this.repository);
  Future<List<EsnadEntity>> call({params}) {
    return repository.getAllEsnadsWithAdkars();
  }
}

