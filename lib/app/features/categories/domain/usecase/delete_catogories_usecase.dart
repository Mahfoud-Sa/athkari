import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

class DeleteCatogoriesUseCase extends UseCase<void, int> {
  final CategoryRepositoryImp _categoryRepository;

  DeleteCatogoriesUseCase(this._categoryRepository);

  @override
  Future call({int? params}) {
    // TODO: implement call
    return _categoryRepository.deleteCatogory(params!);
  }
}
