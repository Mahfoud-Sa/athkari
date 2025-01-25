import 'package:athkari/app/features/daily_wered/data/modules/dhkar.dart';
import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';

class EsnadDao {
  EsnadDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  Future<int> InsertEsnad(EsnadModel esnad) async {
    var value = {
      'name': esnad.name,
      // 'repetitions': dhkar.repetitions,
      // 'esnaad_id': 0,
    };
    return await database.insert("Esnads", value);
  }

  Future<int> UpdateEsnad(int id, EsnadModel esnad) async {
    return await database
        .update('Esnads', esnad.toJson(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteEsnad(int id) async {
    var status =
        await database.delete("Esnads", where: 'id = ?', whereArgs: [id]);
    return status;
  }

  // Example: Get all records
  Future<List<EsnadModel>> getAllEsnads() async {
    var esnads = await database.query('Esnads');
    return esnads.map((esnad) => EsnadModel.fromDataBase(esnad)).toList();
  }
}
