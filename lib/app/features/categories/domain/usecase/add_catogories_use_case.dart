import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository.dart';
import 'package:athkari/app/features/categories/domain/entities/category.dart';

class AddCatogoriesUseCase extends UseCase {
  final CategoryRepositoryImp _categoryRepository;

  AddCatogoriesUseCase(this._categoryRepository);

  @override
  Future<int> call({params}) {
    return _categoryRepository.addCatogory(CategoryEntity(name: "أذكار الصبح"));
  }
}
