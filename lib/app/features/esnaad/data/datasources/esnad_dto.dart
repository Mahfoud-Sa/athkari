import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:sqflite_common/sqlite_api.dart';

class EsnadDao {
  EsnadDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  Future<int> insertEsnad(EsnadModel esnad) async {
    var value = {
      'name': esnad.name,
      // 'repetitions': dhkar.repetitions,
      // 'esnaad_id': 0,
    };
    return await database.insert("Esnads", value);
  }

  Future<int> updateEsnad(int id, EsnadModel esnad) {
    return database
        .update('Esnads', esnad.toDatabse(), where: 'id = ?', whereArgs: [id]);
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
