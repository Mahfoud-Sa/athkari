import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/daily_wered/data/repository/dhkar_repository_impl.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';

class UpdateDekharWithEsnadUsecase implements UseCase<void, (int, DhkarEntity)> {
  final DhkarRepositoryImpl _dhkarRepositoryImpl;
  UpdateDekharWithEsnadUsecase(this._dhkarRepositoryImpl);
  @override
  Future<int> call({(int, DhkarEntity)? params}) async {
    return await _dhkarRepositoryImpl.updateDhkar(
        params!.$1, params.$2);
  }
}
