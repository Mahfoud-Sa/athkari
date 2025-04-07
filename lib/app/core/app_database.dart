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

  Future<void> resetDatabase() async {
    String path;

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      // Use an in-memory database for tests
      path = ':memory:';
    } else {
      // Use the real database path
      String databasePath = await getDatabasesPath();
      path = join(databasePath, 'database.db');
    }
    print(_database!.isOpen);
    if (_database != null) deleteDatabase(path);
    print("delete database successfully");
    print(_database!.isOpen);

    openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    print(_database!.isOpen);

    //_instance._initializeDb();
    //print("database successfully");
  }

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
