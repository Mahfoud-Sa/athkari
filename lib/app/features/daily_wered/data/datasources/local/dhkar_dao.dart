import 'package:sqflite_common/sqlite_api.dart';

class DhkarDao {
  DhkarDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  Future<void> Insert() {
    // TODO: implement Insert
    throw UnimplementedError();
  }

  // Example: Get all records
  Future<List<Map<String, dynamic>>> getAllAdhkai() async {
    return await database.query('Adhkars');
  }
  // Future<void> GetAll();
  // Future<void> Get();

  // Future<void> Update();
  // Future<void> Delete();
}
