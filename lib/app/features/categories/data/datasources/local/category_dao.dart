import 'package:athkari/app/features/categories/data/modules/category.dart';
import 'package:athkari/app/features/categories/domain/entities/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  CategoryDao(this.database);
  final Database database;
  Future<int> insertCategory(CategoryModel category) async {
    return await database.insert('categories', category.toJson());
  }

  Future<int> updateCategory(int id, CategoryModel category) async {
    return await database.update('categories', category.toJson(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(int id) async {
    return await database
        .delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<CategoryModel>> getCategories() async {
    // Query the 'categories' table
    var categories = await database.query('categories');

    // Map the query result to a list of CategoryModel instances
    return categories
        .map((category) => CategoryModel.fromDataBase(category))
        .toList();
  }

  Future<List<Map<String, Object?>>> getCategory(int id) async {
    return await database.query('categories', where: 'id = ?', whereArgs: [id]);
  }
}
// var status = await database
//         .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkar.id]);
//     return status;
