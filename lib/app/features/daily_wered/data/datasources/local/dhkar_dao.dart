import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DhkarDao {
  DhkarDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  Future<bool> Insert(DhkarModel dhkar) async {
    var value = {
      'dhaker': dhkar.dhkar,
      'repetitions': dhkar.repetitions,
      'esnaad_id': 0,
    };
    var status = await database.insert("Adhkars", value);
    if (status == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> Update(DhkarModel dhkar) async {
    var value = {
      'dhaker': dhkar.dhkar,
      'repetitions': dhkar.repetitions,
      'esnaad_id': 0,
    };
    var status = await database
        .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkar.id]);
    return status;
  }

  // Example: Get all records
  Future<List<Map<String, dynamic>>> getAllAdhkai() async {
    var temp = await database.query('Adhkars');
    print(temp);
    return temp;
  }

  Future<int> getTotal() async {
    var result = await database.query('Adhkars');

    return result.length;
  }
  // Future<void> GetAll();
  // Future<void> Get();

  // Future<void> Update();
  // Future<void> Delete();
}
