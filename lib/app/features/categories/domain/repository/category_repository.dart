import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCatogories();
  Future<CategoryEntity?> getCatogory(int id);
  Future<CategoryEntity?> getCatogoryDetails(int id);
  Future<int> addCatogory(CategoryEntity category);
  // Future<int> addCatogorWithEsnad(CategoryEntity category);
  Future<CategoryEntity?> updareCatogory(CategoryEntity category);
  Future<bool> deleteCatogory(int id);
}
