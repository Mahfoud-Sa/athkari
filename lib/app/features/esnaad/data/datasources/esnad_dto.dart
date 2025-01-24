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

  // Future<int> Update(DhkarModel dhkar) async {
  //   var value = {
  //     'dhaker': dhkar.dhkar,
  //     'repetitions': dhkar.repetitions,
  //     'esnaad_id': 0,
  //   };
  //   var status = await database
  //       .update("Adhkars", value, where: 'id = ?', whereArgs: [dhkar.id]);
  //   return status;
  // }

  // Example: Get all records
  Future<List<EsnadModel>> getAllEsnads() async {
    var esnads = await database.query('Esnads');
    return esnads.map((esnad) => EsnadModel.fromDataBase(esnad)).toList();
  }

  // Future<int> getTotal() async {
  //   var result = await database.query('Adhkars');

  //   return result.length;
  // }
  // Future<void> GetAll();
  // Future<void> Get();

  // Future<void> Update();
  // Future<void> Delete();
}
