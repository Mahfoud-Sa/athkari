import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/categories/domain/repository/category_repository.dart';
import 'package:athkari/app/core/app_database.dart';

class CategoryRepositoryImp implements CategoryRepository {
  final AppDataBaseServices _appDataBaseServices;
  CategoryRepositoryImp(this._appDataBaseServices);
  // @override
  // Future<int> addCatogory(CategoryEntity category) async {
  //   return await _appDataBaseServices.categoryDao
  //       .insertCategory(CategoryModel.fromEntity(category));
  // }

  @override
  Future<List<CategoryEntity>> getAllCatogories() {
    return _appDataBaseServices.categoryDao.getCategories();
  }

  @override
  Future<int> addCatogory(CategoryEntity category) {
    // TODO: implement addCatogory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteCatogory(CategoryEntity category) {
    // TODO: implement deleteCatogory
    throw UnimplementedError();
  }

  @override
  Future<CategoryEntity> getCatogory(int id) {
    // TODO: implement getCatogory
    throw UnimplementedError();
  }

  @override
  Future<CategoryEntity> updareCatogory(CategoryEntity category) {
    // TODO: implement updareCatogory
    throw UnimplementedError();
  }

//   @override
// Future<List<Map<String, Object?>>> getAllCatogories() {
//    return _appDataBaseServices.categoryDao.getCategories();
//   }
}
