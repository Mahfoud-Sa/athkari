import 'package:athkari/app/features/categories/data/modules/category.dart';
import 'package:athkari/app/features/categories/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCatogories();
  Future<int> addCatogory();
}
