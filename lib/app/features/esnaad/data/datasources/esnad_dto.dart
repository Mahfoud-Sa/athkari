import 'package:athkari/app/features/esnaad/data/modules/esnad_model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

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

  Future<void> seedEsnads() async {
    for (int i = 0; i < 50; i++) {
      var EsnadText = lorem(paragraphs: 1, words: 20);
      await database.insert(
        'Esnads', // Table name
        {'name': EsnadText}, // Data to insert
        conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
      );
    }
    // await database.insert(
    //   'Categories', // Table name
    //   {'name': lorem(words: 1)}, // Data to insert
    //   conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
    // );
    var temp = await getAllEsnads();
    print(temp);
  }
}
