import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

class AddCatogoriesUseCase extends UseCase<void, CategoryEntity> {
  final CategoryRepositoryImp _categoryRepository;

  AddCatogoriesUseCase(this._categoryRepository);

  @override
  Future call({CategoryEntity? params}) {
    // TODO: implement call
    return _categoryRepository.addCatogory(CategoryEntity(name: params!.name));
  }

  // @override
  // Future<void> call({CategoryEntity? params}) {
  //   return _categoryRepository.addCatogory(CategoryEntity(name: params!.name));
  // }
}
