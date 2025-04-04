import 'dart:io';
import 'package:athkari/app/features/categories/data/datasources/local/category_dao.dart';
import 'package:athkari/app/features/daily_wered/data/datasources/local/daily_wered_dao.dart';
import 'package:athkari/app/features/daily_wered/data/datasources/local/dhkar_dao.dart';
import 'package:athkari/app/features/esnaad/data/datasources/esnad_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDataBaseServices {
  static final AppDataBaseServices _instance = AppDataBaseServices._internal();
  Database? _database;

  AppDataBaseServices._internal();

  factory AppDataBaseServices() {
    return _instance;
  }

  Future<Database?> get db async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  DailyWeredDao get dailyWeredDao {
    if (_database == null) {
      throw Exception(
          "Database not initialized yet. Please wait until it's initialized.");
    }
    return DailyWeredDao(_database!);
  }

  DhkarDao get adhkaiDao {
    if (_database == null) {
      throw Exception(
          "Database not initialized yet. Please wait until it's initialized.");
    }
    return DhkarDao(_database!);
  }

  CategoryDao get categoryDao {
    if (_database == null) {
      throw Exception(
          "Database not initialized yet. Please wait until it's initialized.");
    }
    return CategoryDao(_database!);
  }

  EsnadDao get esnadDao {
    if (_database == null) {
      throw Exception(
          "Database not initialized yet. Please wait until it's initialized.");
    }
    return EsnadDao(_database!);
  }

  Future<Database> _initializeDb() async {
    String path;

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      // Use an in-memory database for tests
      path = ':memory:';
    } else {
      // Use the real database path
      String databasePath = await getDatabasesPath();
      path = join(databasePath, 'database.db');
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Future<Database> _initializeDb() async {
  //   String databasePath = await getDatabasesPath();
  //   String path = join(databasePath, 'database.db');
  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: _onCreate,
  //     onUpgrade: _onUpgrade,
  //   );
  // }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades if needed
  }

  Future<void> _onCreate(Database db, int version) async {
    print("Creating tables...");
    await db.execute('''
      CREATE TABLE DailyWered (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dhaker TEXT ,
        repetitions INTEGER,
        esnads_id,
        is_compeleted bool,
        FOREIGN KEY (esnads_id) REFERENCES Esnads(id) ON DELETE CASCADE

      )
    ''');
    await db.execute('''
      CREATE TABLE Adhkars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dhaker TEXT ,
        repetitions INTEGER,
        category_id,
        esnads_id,
        FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE,
        FOREIGN KEY (esnads_id) REFERENCES Esnads(id) ON DELETE CASCADE

      )
    ''');
    await db.execute('''
      CREATE TABLE Categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT 
      )
    ''');
    await db.execute('''
      CREATE TABLE Esnads (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT 
      )
    ''');
    print("Tables created successfully.");
  }
}

/*
  Future<List<NoteModel>> getAll(Database? mydb) async {
    var response = await mydb!.query("Notes");
    //print(response);
    List<NoteModel> notes =
        response.map((json) => NoteModel.fromJson(json)).toList();
    //print(notes);

    return notes;
  }

  

  deleteData(Database? mydb, int id) async {
    await mydb!.delete("Notes", where: "id=?", whereArgs: [id]);
  }

  get(Database? mydb, String search) async {
    var response = await mydb!.query('Notes',
        // columns: ["id", "title", "content", "date"],
        where: "title LIKE ? or content LIKE ?",
        whereArgs: ["%$search%", "%$search%"]);
    List<NoteModel> notes =
        response.map((json) => NoteModel.fromJson(json)).toList();
    return notes;
  }

  update(Database? mydb, NoteEntity note, int id) async {
    //Database? mydb = await db;
    await mydb!.update(
        'Notes',
        {
          'title': note.title,
          'content': note.content,
          'date': DateTime.now().toIso8601String()
        },
        where: "id=?",
        whereArgs: [id]);
    // return response;
  }


  get(String userName, String password) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.query('students',
        columns: [
          "id",
          "fullName",
          "lastName",
          "country",
          "city",
          "neighborhood",
          "borthDay",
          "gender",
          "userName",
          "password"
        ],
        where: "userName=? and password=?",
        whereArgs: [userName, password]);
    return response;
  }

  getById(int id) async {
    Database? mydb = await db;

    List<Map> response = await mydb!.query('students',
        columns: [
          "id",
          "fullName",
          "lastName",
          "country",
          "city",
          "neighborhood",
          "borthDay",
          "gender",
          "userName",
          "password"
        ],
        where: "id=? ",
        whereArgs: [id]);
    return response;
  }

  create(User user) async {
    Database? mydb = await db;
    int response = await mydb!.insert('students', user.toJson());
    return response;
  }

  

  

  deleteData(int id) async {
    Database? mydb = await db;
    int response =
        await mydb!.delete("students", where: "id=?", whereArgs: [id]);

    return response;
  }

}
*/