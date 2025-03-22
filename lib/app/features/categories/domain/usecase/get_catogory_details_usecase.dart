import 'package:athkari/app/core/usecase/usecase.dart';
import 'package:athkari/app/features/categories/data/repository/category_repository_imp.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

class GetCatogoryDetailsUseCase extends UseCase {
  final CategoryRepositoryImp _categoryRepository;

  GetCatogoryDetailsUseCase(this._categoryRepository);

  @override
  Future<CategoryEntity?> call({params}) async {
    var temp = await _categoryRepository.getCatogoryDetails(params.id);

    return temp;
  }
}
