import 'dart:convert';

import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class DhkarDao {
  DhkarDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  Future<bool> Insert(DhkarModel dhkar) async {
    var value = {
      'dhaker': dhkar.dhkar,
      'repetitions': dhkar.repetitions,
      'esnads_id': dhkar.esnad!.id!,
    };
    var status = await database.insert("Adhkars", value);
    if (status == 0) {
      return false;
    } else {
      return true;
    }
  }

// AdhkaiDao(this._db);
  Future<bool> Delete(int id) async {
    try {
      // Assuming you have an 'id' field in your DhkarModel
      // and your table has a primary key column named 'id'
      int rowsDeleted = await database.delete(
        "Adhkars",
        where: 'id = ?', // Or use your unique identifier column
        whereArgs: [id],
      );

      // Return true if at least one row was deleted
      return rowsDeleted > 0;
    } catch (e) {
      // Handle any errors that might occur during deletion
      debugPrint('Error deleting dhkar: $e');
      return false;
    }
  }

  // AdhkaiDao(this._db);
  Future<int> InsertWitnCategory(int categoryId, DhkarModel dhkar) async {
    var value = {
      'dhaker': dhkar.dhkar,
      'repetitions': dhkar.repetitions,
      'esnads_id': dhkar.esnad!.id!,
      'category_id': categoryId
    };
    var state = await database.insert("Adhkars", value);
    return state;
  }

  Future<int> addToDaily(int dhkarId, int repetitions) async {
    var value = {'in_daily_wered': true, 'repetitions': repetitions};
    var status = await database
        .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkarId]);
    return status;
  }

  Future<int> Update(int categoryId, DhkarModel dhkar) async {
    var value = {
      'dhaker': dhkar.dhkar,
      'repetitions': dhkar.repetitions,
      'esnads_id': dhkar.esnad!.id!,
      'category_id': categoryId
    };
    var status = await database
        .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkar.id]);
    return status;
  }

  Future<DhkarModel?> getDhkarById(int id) async {
    try {
      final List<Map<String, dynamic>> results = await database.query(
        'Adhkars',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (results.isNotEmpty) {
        return DhkarModel.fromDataBase(results.first);
      }
      return null; // Return null if no record found with this ID
    } catch (e) {
      print('Error getting dhkar by id: $e');
      rethrow; // or handle the error as appropriate
    }
  }

  // Example: Get all records
  Future<List<DhkarModel>> getAllAdhkai() async {
    var dekars = await database.query('Adhkars');
    print(dekars);
    return dekars.map((dekar) => DhkarModel.fromDataBase(dekar)).toList();
  }

  Future<List<DailyWeredModel>> getAllDailyWereds() async {
    var dekars = await database.query(
      'Adhkars',
      where: 'in_daily_wered = ?',
      whereArgs: [true],
    );
    print(dekars);

    return dekars.map((dekar) => DailyWeredModel.fromDataBase(dekar)).toList();
  }

  Future<int> getTotal() async {
    var result = await database.query('Adhkars');

    return result.length;
  }

  Future<void> resetAdhkars() async {
    database.execute('DROP TABLE IF EXISTS Adhkars');
    database.execute('''
      CREATE TABLE Adhkars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dhaker TEXT ,
        repetitions INTEGER,
        is_compeleted bool,
        in_daily_wered bool,
        category_id,
        esnads_id,
        FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE,
        FOREIGN KEY (esnads_id) REFERENCES Esnads(id) ON DELETE CASCADE

      )
    ''');
    seedAdhkars();
  }

  Future<void> seedAdhkars() async {
    // database.delete('Adhkars');
    // database.rawUpdate(
    //   'DELETE FROM sqlite_sequence WHERE name = ?',
    //   ["Adhkars"],
    // );
    String jsonString =
        await rootBundle.loadString('assets/jsons/adhkars.json');
    var adhkarsList = jsonDecode(jsonString);

    for (int i = 0; i < adhkarsList.length; i++) {
      var temp = await database.insert(
        'Adhkars', // Table name
        {
          'dhaker': adhkarsList[i]['dhaker'],
          'repetitions': adhkarsList[i]['repetitions'],
          'category_id': adhkarsList[i]['category_id'],
          "esnads_id": adhkarsList[i]['esnads_id']
        }, // Data to insert
        conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      );
      print(temp);
    }
  }
}
