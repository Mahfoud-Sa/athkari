import 'dart:convert';
import 'dart:io';
import 'package:athkari/app/core/constrainsa.dart';
import 'package:athkari/app/features/categories/data/datasources/local/category_dao.dart';
import 'package:athkari/app/features/daily_wered/data/datasources/local/daily_wered_dao.dart';
import 'package:athkari/app/features/daily_wered/data/datasources/local/dhkar_dao.dart';
import 'package:athkari/app/features/esnaad/data/datasources/esnad_dto.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();

      databaseFactory = databaseFactoryFfi;
    }
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

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades if needed
  }

  Future<void> _onCreate(Database db, int version) async {
    print("Creating tables...");
    await db.execute('''
      CREATE TABLE Adhkars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dhaker TEXT ,
        repetitions INTEGER,
        is_compeleted bool,
        in_daily_wered bool,
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

  Future<void> clearAllTablesFromInternet() async {
    if (_database == null || !_database!.isOpen) {
      throw Exception("Database is not initialized");
    }
    print("seeding tables .");
    // Perform in a transaction for atomicity
    await _database!.transaction((txn) async {
      // Clear all tables

      await txn.delete('Adhkars');
      await txn.delete('Categories');
      await txn.delete('Esnads');

      // Reset auto-increment counters for all tables
      await txn.rawDelete('DELETE FROM sqlite_sequence');
    });

    // Reseed the database
    await seedDatabaseInternet();
  }

  Future<void> clearAllTablesFromJson() async {
    if (_database == null || !_database!.isOpen) {
      throw Exception("Database is not initialized");
    }
    print("seeding tables .");
    // Perform in a transaction for atomicity
    await _database!.transaction((txn) async {
      // Clear all tables

      await txn.delete('Adhkars');
      await txn.delete('Categories');
      await txn.delete('Esnads');

      // Reset auto-increment counters for all tables
      await txn.rawDelete('DELETE FROM sqlite_sequence');
    });

    // Reseed the database
    await seedDatabaseFromJson();
  }

  Future<void> _seedAdhkarsFromInternet() async {
    try {
      // Load and parse JSON
      // final jsonString = await rootBundle.loadString('assets/jsons/adhkars.json');
      // final adhkarsList = jsonDecode(jsonString) as List<dynamic>;
      const String jsonUrl =
          'https://raw.githubusercontent.com/Mahfoud-Sa/athkari/main/assets/jsons/adhkars.json';

      String downloadPath = '';

      await FileDownloader.downloadFile(
          url: jsonUrl,
          name: "categories.json", //(optional)
          subPath: "jsons",
          onProgress: (name, progress) {
            print('DOWNLOAD PROGRESS: $progress%');
          },
          downloadDestination: DownloadDestinations.appFiles,
          onDownloadCompleted: (String path) {
            downloadPath = path;
            print('FILE DOWNLOADED TO PATH: $path');
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
          });

      final file = File(downloadPath);
      final jsonString = await file.readAsString();
      final adhkarsList = jsonDecode(jsonString) as List;

      // Get database instance
      final db = await AppDataBaseServices().db;
      if (db == null) throw Exception('Database not initialized');

      // Use transaction for better performance and atomicity
      await db.transaction((txn) async {
        for (final adhkar in adhkarsList) {
          await txn.insert(
            'Adhkars',
            _mapAdhkarToDbRow(adhkar),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });

      print('Successfully seeded ${adhkarsList.length} adhkars');
    } catch (e) {
      throw Exception('Failed to seed adhkars: $e');
    }
  }

  Map<String, dynamic> _mapAdhkarToDbRow(dynamic adhkar) {
    return {
      'dhaker': adhkar['dhaker'] as String,
      'repetitions': adhkar['repetitions'] as int,
      'category_id': adhkar['category_id'] as int,
      'in_daily_wered':
          adhkar['in_daily_wered'] ? null : adhkar['in_daily_wered'] as bool,
      'esnads_id': adhkar['esnads_id'] as int,
    };
  }

  Future<void> seedDatabaseFromJson() async {
    try {
      // Load and parse categories
      await _seedEsnadsFromJson();
      await _seedCategoriesFromJson();
      await _seedAdhkarsFromJson();

      //
    } catch (e) {
      throw Exception('Failed to seed database: $e');
    }
  }

  Future<void> seedDatabaseInternet() async {
    try {
      // Load and parse categories
      await _seedEsnadsFromInternet();
      await _seedCategoriesFromInternet();
      await _seedAdhkarsFromInternet();

      // await _seedDailyWered();
    } catch (e) {
      throw Exception('Failed to seed database: $e');
    }
  }

  Future<void> _seedCategoriesFromInternet() async {
    // final jsonString = await rootBundle.loadString('assets/jsons/categories.json');
    // final categoryList = jsonDecode(jsonString) as List<dynamic>;
    const String jsonUrl =
        'https://raw.githubusercontent.com/Mahfoud-Sa/athkari/main/assets/jsons/categories.json';

    String downloadPath = '';

    await FileDownloader.downloadFile(
        url: jsonUrl,
        name: "categories.json", //(optional)
        subPath: "jsons",
        onProgress: (name, progress) {
          print('DOWNLOAD PROGRESS: $progress%');
        },
        downloadDestination: DownloadDestinations.appFiles,
        onDownloadCompleted: (String path) {
          downloadPath = path;
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        });

    final file = File(downloadPath);
    final jsonString = await file.readAsString();
    final categoryList = jsonDecode(jsonString) as List;

    final db = await AppDataBaseServices().db;
    if (db == null) throw Exception('Database not initialized');

    await db.transaction((txn) async {
      for (final category in categoryList) {
        await txn.insert(
          'Categories',
          {'name': category['name']},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> _seedEsnadsFromInternet() async {
    const String jsonUrl =
        'https://raw.githubusercontent.com/Mahfoud-Sa/athkari/main/assets/jsons/esnads.json';

    String downloadPath = '';

    await FileDownloader.downloadFile(
        url: jsonUrl,
        name: "esnads.json", //(optional)
        subPath: "jsons",
        onProgress: (name, progress) {
          print('DOWNLOAD PROGRESS: $progress%');
        },
        downloadDestination: DownloadDestinations.appFiles,
        onDownloadCompleted: (String path) {
          downloadPath = path;
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        });

    final file = File(downloadPath);
    final jsonString = await file.readAsString();
    final esnads = jsonDecode(jsonString) as List;

    final db = await this.db;
    if (db == null) throw Exception('Database not initialized');

    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final esnad in esnads) {
        batch.insert(
          'Esnads',
          {'name': esnad['name'].toString()},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
    });
  }

  Future<void> _seedEsnadsFromJson() async {
    final jsonString = await rootBundle.loadString('assets/jsons/esnads.json');

    final esnads = jsonDecode(jsonString) as List;

    final db = await this.db;
    if (db == null) throw Exception('Database not initialized');

    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final esnad in esnads) {
        batch.insert(
          'Esnads',
          {'name': esnad['name'].toString()},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
    });
  }

  Future<void> _seedCategoriesFromJson() async {
    final jsonString =
        await rootBundle.loadString('assets/jsons/categories.json');
    final categoryList = jsonDecode(jsonString) as List<dynamic>;

    // final jsonString = await file.readAsString();
    // final categoryList = jsonDecode(jsonString) as List;

    final db = await AppDataBaseServices().db;
    if (db == null) throw Exception('Database not initialized');

    await db.transaction((txn) async {
      for (final category in categoryList) {
        await txn.insert(
          'Categories',
          {'name': category['name']},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<void> _seedAdhkarsFromJson() async {
    try {
      // Load and parse JSON
      final jsonString =
          await rootBundle.loadString('assets/jsons/adhkars.json');
      final adhkarsList = jsonDecode(jsonString) as List<dynamic>;

      // Get database instance
      final db = await AppDataBaseServices().db;
      if (db == null) throw Exception('Database not initialized');

      // Use transaction for better performance and atomicity
      await db.transaction((txn) async {
        for (final adhkar in adhkarsList) {
          await txn.insert(
            'Adhkars',
            _mapAdhkarToDbRow(adhkar),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });

      print('Successfully seeded ${adhkarsList.length} adhkars');
    } catch (e) {
      throw Exception('Failed to seed adhkars: $e');
    }
  }
}
