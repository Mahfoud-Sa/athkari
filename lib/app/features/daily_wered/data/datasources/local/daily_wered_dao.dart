import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class DailyWeredDao {
  DailyWeredDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  // Future<bool> Insert(DhkarModel dhkar) async {
  //   var value = {
  //     'dhaker': dhkar.dhkar,
  //     'repetitions': dhkar.repetitions,
  //     'esnads_id': dhkar.esnad!.id!,
  //   };
  //   var status = await database.insert("Adhkars", value);
  //   if (status == 0) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // // AdhkaiDao(this._db);
  // Future<int> InsertWitnCategory(int categoryId, DhkarModel dhkar) async {
  //   var value = {
  //     'dhaker': dhkar.dhkar,
  //     'repetitions': dhkar.repetitions,
  //     'esnads_id': dhkar.esnad!.id!,
  //     'category_id': categoryId
  //   };
  //   var state = await database.insert("Adhkars", value);
  //   return state;
  // }

  // Future<int> Update(DhkarModel dhkar) async {
  //   var value = {
  //     'dhaker': dhkar.dhkar,
  //     'repetitions': dhkar.repetitions,
  //     'esnads_id': 0,
  //   };
  //   var status = await database
  //       .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkar.id]);
  //   return status;
  // }

  // Example: Get all records
  Future<List<DailyWeredModel>> getAllAdhkai() async {
    var dekars = await database
        .query('DailyWered', where: "is_compeleted = ?", whereArgs: ["false"]);
    print(dekars);
    return dekars.map((dekar) => DailyWeredModel.fromDataBase(dekar)).toList();
  }
 Future<int> getTotalDailyWered() async {
    var dekars = await database
        .query('DailyWered');
    print(dekars);
    return dekars.map((dekar) => DailyWeredModel.fromDataBase(dekar)).toList().length;
  }
  Future<int> getCompeletedDailyWered() async {
    var dekars = await database
        .query('DailyWered', where: "is_compeleted = ?", whereArgs: ["true"]);
    print(dekars);
    return dekars.map((dekar) => DailyWeredModel.fromDataBase(dekar)).toList().length;
  }
  Future<int> getTotal() async {
    var result = await database.query('Adhkars');

    return result.length;
  }

  Future<int> doneDailyWered(int id) async {
    try {
      var state = await database.update(
        'DailyWered', // table name
        {"is_compeleted": true}, // Map of column names to values
        where: 'id = ?', // WHERE clause to identify the record
        whereArgs: [id], // Values for the WHERE clause
      );
      print(state);
      return state;
    } catch (e) {
      print('Error updating item: $e');
      return 0;
    }
  }

  Future<int> updateRepetation(int id, int repetation) async {
    try {
      var state = await database.update(
        'DailyWered', // table name
        {"repetitions": repetation}, // Map of column names to values
        where: 'id = ?', // WHERE clause to identify the record
        whereArgs: [id], // Values for the WHERE clause
      );
      print(state);
      return state;
    } catch (e) {
      print('Error updating item: $e');
      return 0;
    }
  }

  Future<void> seedDailyWered() async {
    for (int i = 0; i < 10; i++) {
      var dhkarName = lorem(words: 1);
      var value = {
        'dhaker': dhkarName,
        'repetitions': i,
        'esnads_id': 0,
        'is_compeleted': "false"
      };

      await database.insert("DailyWered", value);
      // await database.insert(
      //   'Adhkars', // Table name
      //   {'name': dhkarName, 'category_id': 1}, // Data to insert
      //   conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      // );
    }
  }

  Future<int> deleteDailyWered(int id) async {
    var state =
        await database.delete('DailyWered', where: "id=?", whereArgs: [id]);
    print(state);
    return state;
  }
}
