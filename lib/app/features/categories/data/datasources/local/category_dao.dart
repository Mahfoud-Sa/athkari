import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class CategoryDao {
  CategoryDao(this.database);
  final Database database;
  Future<int> insertCategory(CategoryModel category) async {
    return await database.insert('categories', category.toDatabase());
  }

  Future<int> updateCategory(int id, CategoryModel category) async {
    return await database.update('categories', category.toDatabase(),
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

  Future<void> seedCategory() async {
    for (int i = 0; i < 50; i++) {
      var categoryName = lorem(words: 1);
      await database.insert(
        'Categories', // Table name
        {'name': categoryName}, // Data to insert
        conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      );
    }
    // await database.insert(
    //   'Categories', // Table name
    //   {'name': lorem(words: 1)}, // Data to insert
    //   conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
    // );
    var temp = await getCategories();
    print(temp);
  }
}
