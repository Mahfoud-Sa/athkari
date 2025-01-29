import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/categories/domain/entities/category_entity.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class CategoryDao {
  CategoryDao(this.database);
  final Database database;

  Future<int> insertCategory(CategoryModel category) async {
    return await database.insert('Categories', {"name": category.name});
  }
//  Future<int> insertCategoryWithDekar(CategoryModel category) async {

//     int categoryIndex= await database.insert('categories', category.toDatabase());

//     var value = {
//       'dhaker': dhkar.dhkar,
//       'repetitions': dhkar.repetitions,
//       'esnaad_id': 0,
//     };
//     var status = await database.insert("Adhkars", value);

//      await database.insert('Adhkars', category.toDatabase());
//   }
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
    print(categories);
    // Map the query result to a list of CategoryModel instances
    return categories
        .map((category) => CategoryModel.fromDataBase(category))
        .toList();
  }

  Future<List<CategoryModel>> getCategoriesWithDekars() async {
    final query = '''
  SELECT 
    categories.id AS id, 
    categories.name AS name,  
    Adhkars.dhaker AS dhaker
  FROM categories 
  LEFT JOIN Adhkars ON categories.id = Adhkars.category_id
''';

    final List<Map<String, dynamic>> result = await database.rawQuery(query);
    var temp = result
        .fold<Map<int, CategoryModel>>({}, (map, row) {
          int categoryId = row['id'];
          String categoryName = row['name'];

          // Add category if it doesn't exist in the map
          map.putIfAbsent(
            categoryId,
            () => CategoryModel(
              id: categoryId,
              name: categoryName,
              dhkars: [],
            ),
          );

          // Add adhkar if it's not null
          if (row['dhaker'] != null) {
            map[categoryId]!.dhkars!.add(DhkarModel(dhkar: row['dhaker']));
          }

          return map;
        })
        .values
        .toList();
    // print(result);
    return temp;
    // Map to store categories with their dekars
    // Map<int, CategoryModel> categoryMap = {};

    // for (var row in result) {
    //   int categoryId = row['id'] as int;

    //   if (!categoryMap.containsKey(categoryId)) {
    //     categoryMap[categoryId] = CategoryModel.fromDataBase(row);
    //     categoryMap[categoryId]!.. = [];
    //   }

    //   // If there is a dekar, add it to the list
    //   if (row['dekar_id'] != null) {
    //     categoryMap[categoryId]!.dekars.add(
    //       DekarModel(
    //         id: row['dekar_id'] as int,
    //         name: row['dekar_name'] as String,
    //         categoryId: row['category_id'] as int,
    //       ),
    //     );
    //   }
    // }

    // return categoryMap.values.toList();
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
    //  print(temp);
  }
}
