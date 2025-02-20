import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

class AddCategoryWithDekharUsecase implements UseCase<void, CategoryEntity> {
  final CategoryRepositoryImp _esnadRepositoryImp;
  AddCategoryWithDekharUsecase(this._esnadRepositoryImp);
  @override
  Future<int> call({CategoryEntity? params}) async {
    return await _esnadRepositoryImp
        .addCatogorWithEsnad(CategoryEntity(name: params!.name));
  }
}
