import 'package:sqflite_common/sqlite_api.dart';

class DhkarDao {
  DhkarDao(this.database);
  final Database database;

  // AdhkaiDao(this._db);
  Future<bool> Insert(String name, int esnadd) async {
    var value = {
      'dhaker': name,
      'repetitions': esnadd,
      'esnaad_id': 0,
    };
    var status = await database.insert("Adhkars", value);
    if (status == 0) {
      return false;
    } else {
      return true;
    }
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
