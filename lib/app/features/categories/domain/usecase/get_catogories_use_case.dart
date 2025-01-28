import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

class GetCatogoriesUseCase extends UseCase {
  final CategoryRepositoryImp _categoryRepository;

  GetCatogoriesUseCase(this._categoryRepository);

  @override
  Future<List<CategoryEntity>> call({params}) {
    return _categoryRepository.getAllCatogories();
  }
}
