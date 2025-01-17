import 'package:athkari/app/features/categories/data/modules/category.dart';
import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:athkari/app/features/categories/domain/repository/category_repository.dart';
import 'package:athkari/app/features/daily_wered/data/datasources/app_database.dart';

class CategoryRepositoryImp implements CategoryRepository {
  final AppDataBaseServices _appDataBaseServices;
  CategoryRepositoryImp(this._appDataBaseServices);
  @override
  Future<int> addCatogory(CategoryEntity category) {
    return _appDataBaseServices.categoryDao
        .insertCategory(CategoryModel.fromEntity(category));
  }

  @override
  Future<List<CategoryEntity>> getAllCatogories() {
    return _appDataBaseServices.categoryDao.getCategories();
  }

//   @override
// Future<List<Map<String, Object?>>> getAllCatogories() {
//    return _appDataBaseServices.categoryDao.getCategories();
//   }
}
