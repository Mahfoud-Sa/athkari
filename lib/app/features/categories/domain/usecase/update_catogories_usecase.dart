import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

class UpdateCatogoriesUseCase extends UseCase<CategoryEntity?, CategoryEntity> {
  final CategoryRepositoryImp _categoryRepository;

  UpdateCatogoriesUseCase(this._categoryRepository);

  @override
  Future<CategoryEntity?> call({CategoryEntity? params}) {
    // TODO: implement call
    return _categoryRepository.updareCatogory(params!);
  }

  // @override
  // Future<void> call({CategoryEntity? params}) {
  //   return _categoryRepository.addCatogory(CategoryEntity(name: params!.name));
  // }
}
