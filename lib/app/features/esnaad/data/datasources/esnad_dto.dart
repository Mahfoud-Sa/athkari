import 'package:athkari/app/features/daily_wered/data/modules/dhkar_model.dart';
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

  Future<List<EsnadModel>> getAllEsnadsWithDekars() async {
    final query = '''
  SELECT 
    Esnads.id AS id, 
    Esnads.name AS name,  
    Adhkars.dhaker AS dhaker
  FROM Esnads 
  LEFT JOIN Adhkars ON Esnads.id = Adhkars.category_id
''';

    final List<Map<String, dynamic>> result = await database.rawQuery(query);
    var temp = result
        .fold<Map<int, EsnadModel>>({}, (map, row) {
          int categoryId = row['id'];
          String categoryName = row['name'];

          // Add category if it doesn't exist in the map
          map.putIfAbsent(
            categoryId,
            () => EsnadModel(
              id: categoryId,
              name: categoryName,
              dekarsList: [],
            ),
          );

          // Add adhkar if it's not null
          if (row['dhaker'] != null) {
            map[categoryId]!.dekarsList!.add(DhkarModel(dhkar: row['dhaker']));
          }

          return map;
        })
        .values
        .toList();
    return temp;
    // var esnads = await database.query('Esnads');
    // return esnads.map((esnad) => EsnadModel.fromDataBase(esnad)).toList();
  }

  // Future<void> seedEsnads() async {
  //   for (int i = 0; i < 50; i++) {
  //     var EsnadText = lorem(paragraphs: 1, words: 20);
  //     await database.insert(
  //       'Esnads', // Table name
  //       {'name': "EsnadText"}, // Data to insert
  //       conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
  //     );
  //   }
  //   // await database.insert(
  //   //   'Categories', // Table name
  //   //   {'name': lorem(words: 1)}, // Data to insert
  //   //   conflictAlgorithm: ConflictAlgorithm.replace, // Handle conflicts
  //   // );
  //   var temp = await getAllEsnads();
  //   print(temp);
  // }

  Future<void> seedEsnads() async {
    List<String> esnadsList = [
      "*«بِسْمِ اللَّهِ الَّذِي لا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ ثَلاثَ مَرَّاتٍ، ثلاثًا » من قالها لَمْ يَضُرَّهُ شَيْءٌ. رواه أبو داود (5088). وهو في الصحيح المسند للإمام الوادعي رحمه الله.",
      "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ خَلَقْتَنِي وَأَنَا عَبْدُكَ وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ وَأَبُوءُ لَكَ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لا يَغْفِرُ الذُّنُوبَ إِلا أَنْتَ » قَالَ ﷺ : مَنْ قَالَهَا مِنْ النَّهَارِ مُوقِنًا بِهَا فَمَاتَ مِنْ يَوْمِهِ قَبْلَ أَنْ يُمْسِيَ فَهُوَ مِنْ أَهْلِ الْجَنَّةِ وَمَنْ قَالَهَا مِنْ اللَّيْلِ وَهُوَ مُوقِنٌ بِهَا فَمَاتَ قَبْلَ أَنْ يُصْبِحَ فَهُوَ مِنْ أَهْلِ الْجَنَّةِ» أخرجه البخاري عن شداد بن أوس (6306)."
    ];
    for (int i = 0; i < esnadsList.length; i++) {
      // var EsnadText = lorem(paragraphs: 1, words: 20);
      await database.insert(
        'Esnads', // Table name
        {'name': esnadsList[i]}, // Data to insert
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
