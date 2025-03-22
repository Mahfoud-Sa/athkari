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

  Future<List<CategoryEntity>> getAllCatogoriesWithDekars() {
    return _appDataBaseServices.categoryDao.getCategoriesWithDekars();
  }

  @override
  Future<int> addCatogory(CategoryEntity category) {
    return _appDataBaseServices.categoryDao
        .insertCategory(CategoryModel(name: category.name));
  }

  @override
  Future<bool> deleteCatogory(int id) async {
    var state = await _appDataBaseServices.categoryDao.deleteCategory(id);
    if (state != 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<CategoryEntity?> getCatogory(int id) {
    return _appDataBaseServices.categoryDao.getCategory(id);
  }

  @override
  Future<CategoryEntity?> updareCatogory(CategoryEntity category) async {
    int updatedCategoryIndex = await _appDataBaseServices.categoryDao
        .updateCategory(category.id!, CategoryModel(name: category.name));
    return await getCatogory(updatedCategoryIndex);
  }

  @override
  Future<CategoryEntity?> getCatogoryDetails(int id) {
    return _appDataBaseServices.categoryDao.getCategoryDetailes(id);
  }
}
