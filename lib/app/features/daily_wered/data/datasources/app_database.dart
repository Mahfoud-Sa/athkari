//import 'package:note/app/features/manage_notes/data/models/note.dart';
//import 'package:note/app/features/manage_notes/domain/entities/note.dart';

import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataBaseServices {
  static Database? _db;
  // late ArticleDao articleDao;

  // AppDataBaseServices();
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'database.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    //  articleDao = ArticleDao(AppDataBase: mydb);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {}

  _onCreate(Database db, int version) async {
    print("Table created successfully.");
//     await db.execute('''

//   CREATE TABLE "sources" (
//     "sourceId" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
//     "id" TEXT NULL,
//     "name" TEXT NULL

//  )

//  ''');
    await db.execute('''
  
  CREATE TABLE "articles" ( 
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "source_id" TEXT NULL,
    "source_name" TEXT NULL,
    "title" TEXT NULL,
    "author" TEXT NULL,
    "description" TEXT NULL,
    "url" TEXT NULL,
    "urlToImage" TEXT NULL,
    "content" TEXT NULL 
 )

 ''');
    //  //  "publishedAt" String NULL,
  }

  // create(Database? mydb, ArticleEntity article) async {
  //   return await mydb!.insert(
  //     'articles',
  //     {
  //       'source_id': article.source!.id,
  //       'name_name': article.source!.name,
  //       'author': article.author,
  //       'title': article.title,
  //       'description': article.descripution,
  //       'url': article.url,
  //       'urlToImage': article.urlToImage,
  //       //   'publishedAt': article.publishedAt!.toString(),
  //       'content': article.content,
  //     },
  //   );
  // }
/*
  getAll(Database? mydb) async {
    //var response = await mydb!.rawQuery("SELECT articles.* from articles INNER JOIN sources ON articles.source = sources.id");
    List<dynamic> response = await mydb!.rawQuery(
        "SELECT articles.*, sources.* FROM articles INNER JOIN sources ON articles.source = sources.id;");

    //print(response);
//List<NoteModel> notes =
    //    response.map((json) => NoteModel.fromJson(json)).toList();
    //print(notes);

    return response;
  }

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
*/
}
