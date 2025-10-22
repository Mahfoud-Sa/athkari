import 'dart:convert';
import 'package:athkari/app/features/categories/data/modules/category_models.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  CategoryDao(this.database);
  final Database database;

  Future<int> insertCategory(CategoryModel category) async {
    return await database.insert('Categories', {"name": category.name});
  }

  Future<int> insertCategoryWithDekhar(CategoryModel category) async {
    await database.insert('Categories', {"name": category.name});
    //  await database.insert('Dekhar', {"name": category.});
    return await database.insert('Categories', {"name": category.name});
  }

  Future<int> updateCategory(int id, CategoryModel category) async {
    return await database.update('categories', {"name": category.name},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(int id) async {
    return await database
        .delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<CategoryModel>> getCategories() async {
    var categories = await database.query('categories');
    return categories
        .map((category) => CategoryModel.fromDataBase(category))
        .toList();
  }

//   Future<List<CategoryModel>> getCategoriesWithDekars() async {
//     final query = '''
//   SELECT
//     categories.id AS id,
//     categories.name AS name,
//     Adhkars.dhaker AS dhaker,
//     Adhkars.repetitions AS repetitions,
//     CASE WHEN DailyWered.id IS NOT NULL THEN 1 ELSE 0 END AS inDailyWered
//   FROM categories
//     LEFT JOIN Adhkars ON categories.id = Adhkars.category_id
//     LEFT JOIN DailyWered ON Adhkars.dhaker = DailyWered.dhaker
//       AND Adhkars.repetitions = DailyWered.repetitions
// ''';

//     final List<Map<String, dynamic>> result = await database.rawQuery(query);

//     var temp = result
//         .fold<Map<int, CategoryModel>>({}, (map, row) {
//           int categoryId = row['id'];
//           String categoryName = row['name'];
//           bool inDailyWered = row['inDailyWered'] == 1;

//           // Add category if it doesn't exist in the map
//           map.putIfAbsent(
//             categoryId,
//             () => CategoryModel(
//               id: categoryId,
//               name: categoryName,
//               dhkars: [],
//               inDailyWered: inDailyWered,
//             ),
//           );

//           // Add adhkar if it's not null
//           if (row['dhaker'] != null) {
//             map[categoryId]!.dhkars!.add(DhkarModel(
//                 dhkar: row['dhaker'], repetitions: row['repetitions']));
//           }

//           return map;
//         })
//         .values
//         .toList();
//     print(temp);
//     return temp;
//   }

  Future<List<CategoryModel>> getCategoriesWithDekars() async {
    final query = '''
  SELECT
    categories.id AS id,
    categories.name AS name,
    Adhkars.dhaker AS dhaker,
    Adhkars.repetitions AS repetitions
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
            map[categoryId]!.dhkars!.add(DhkarModel(
                dhkar: row['dhaker'], repetitions: row['repetitions']));
          }

          return map;
        })
        .values
        .toList();
    // var temp_ = (temp[0]);
    // print(temp[0]);
    return temp;
  }

  Future<CategoryModel?> getCategory(int id) async {
    var result =
        await database.query('categories', where: 'id = ?', whereArgs: [id]);
    return result
        .map((category) => CategoryModel.fromDataBase(category))
        .toList()[0];
  }

  // Future<CategoryModel?> getCategoryDetailes(int id) async {
  //   CategoryModel? categoryName = await getCategory(id);

  //   final result = await database.rawQuery('''
  //     SELECT
  //       Adhkars.id AS adhkar_id,
  //       Adhkars.dhaker,
  //       Adhkars.repetitions,
  //       Adhkars.category_id,
  //       Adhkars.esnads_id,
  //       Esnads.id AS esnad_id,
  //       Esnads.name AS esnad_name,
  //       CASE
  //         WHEN EXISTS (
  //           SELECT 1 FROM DailyWered
  //           WHERE DailyWered.dhaker = Adhkars.dhaker
  //           AND DailyWered.repetitions = Adhkars.repetitions
  //         ) THEN 1
  //         ELSE 0
  //       END AS inDailyWered
  //     FROM Adhkars
  //     LEFT JOIN Esnads ON Adhkars.esnads_id = Esnads.id
  //     WHERE Adhkars.category_id = ?
  //   ''', [id]);
  //   // Debug print to see raw results
  //   print('RAW QUERY RESULTS:');
  //   for (var row in result) {
  //     print(
  //         'Dhkar: ${row['dhaker']}, Repetitions: ${row['repetitions']}, inDailyWered: ${row['inDailyWered']}');
  //   }

  //   // Also print what's in DailyWered for comparison
  //   final dailyWeredContents =
  //       await database.rawQuery('SELECT dhaker, repetitions FROM DailyWered');
  //   print('DAILY WERED CONTENTS: $dailyWeredContents');
  //   debugPrint(result.toString());

  //   List<DhkarModel> dekhars =
  //       result.map((dekar) => DhkarModel.fromDataBase_1(dekar)).toList();

  //   return CategoryModel(
  //     id: id,
  //     name: categoryName!.name,
  //     dhkars: dekhars,
  //   );
  // }
  Future<CategoryModel?> getCategoryDetailes(int id) async {
    CategoryModel? categoryName = await getCategory(id);

    final result = await database.rawQuery('''
    SELECT
      Adhkars.id AS adhkar_id,
      Adhkars.dhaker,
      Adhkars.repetitions,
      Adhkars.category_id,
      Adhkars.esnads_id,
      Adhkars.in_daily_wered,
      Esnads.id AS esnad_id,
      Esnads.name AS esnad_name
    FROM Adhkars
    LEFT JOIN Esnads ON Adhkars.esnads_id = Esnads.id
    WHERE Adhkars.category_id = ?
  ''', [id]);

    debugPrint(result.toString());

    List<DhkarModel> dekhars =
        result.map((dekar) => DhkarModel.fromDataBase_1(dekar)).toList();
    print(dekhars.first.id);
    print(dekhars.first.inDailyWered);
    return CategoryModel(
      name: categoryName!.name,
      dhkars: dekhars,
    );
  }

  Future<void> seedCategory() async {
    database.execute('DROP TABLE IF EXISTS Categories');
    database.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT 
      )
    ''');
//     database.delete('categories');
// var temp_= database.execute('DELETE FROM sqlite_sequence WHERE name="categories"');
//     print(temp_);
    String jsonString =
        await rootBundle.loadString('assets/jsons/categories.json');
    var categoryList = jsonDecode(jsonString);

    for (int i = 0; i < categoryList.length; i++) {
      await database.insert(
        'Categories', // Table name
        {'name': categoryList[i]['name']}, // Data to insert
        conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      );
    }

    var temp = await getCategories();
    print(temp);
  }

  Future<void> resetCategory() async {
    database.execute('DROP TABLE IF EXISTS Categories');
    database.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT 
      )
    ''');
    database.execute('DROP TABLE IF EXISTS Adhkars');
    database.execute('''
      CREATE TABLE Adhkars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dhaker TEXT ,
        repetitions INTEGER,
        category_id,
        esnads_id,
        FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE,
        FOREIGN KEY (esnads_id) REFERENCES Esnads(id) ON DELETE CASCADE

      )
    ''');
    seedCategory();
  }
}
