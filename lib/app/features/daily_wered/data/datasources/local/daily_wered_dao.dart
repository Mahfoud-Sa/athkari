import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class DailyWeredDao {
  DailyWeredDao(this.database);
  final Database database;

  
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
      var temp=database.insert("DailyWered", value);
      await temp;
      
    }
  }

  Future<int> deleteDailyWered(int id) async {
    var state =
        await database.delete('DailyWered', where: "id=?", whereArgs: [id]);
    print(state);
    return state;
  }
}
