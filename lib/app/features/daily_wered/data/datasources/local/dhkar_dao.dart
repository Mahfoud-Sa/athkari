import 'dart:convert';

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

  Future<int> Update(DhkarModel dhkar) async {
    var value = {
      'dhaker': dhkar.dhkar,
      'repetitions': dhkar.repetitions,
      'esnads_id': 0,
    };
    var status = await database
        .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkar.id]);
    return status;
  }

  // Example: Get all records
  Future<List<DhkarModel>> getAllAdhkai() async {
    var dekars = await database.query('Adhkars');
    print(dekars);
    return dekars.map((dekar) => DhkarModel.fromDataBase(dekar)).toList();
  }

  Future<int> getTotal() async {
    var result = await database.query('Adhkars');

    return result.length;
  }

  Future<void> seedAdhkars() async {
    String jsonString =
        await rootBundle.loadString('assets/jsons/adhkars.json');
    var adhkarsList = jsonDecode(jsonString);

    for (int i = 0; i < adhkarsList.length; i++) {
      await database.insert(
        'Adhkars', // Table name
        {
          'dhaker': adhkarsList[i]['dhaker'],
          'repetitions': adhkarsList[i]['repetitions'],
          'category_id': adhkarsList[i]['category_id'],
          "esnads_id": adhkarsList[i]['esnads_id']
        }, // Data to insert
        conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      );
    }
  }
}
