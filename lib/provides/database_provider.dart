import 'package:flutter/material.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider with ChangeNotifier{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  ///get database if exist or create one.
  Future<Database> get database async {
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }
  /// initializing database
  Future<Database> initDB() async{
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'comics_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE comics("
              "num INTEGER PRIMARY KEY, "
              "title TEXT, "
              "safeTitle INTEGER, "
              "alt TEXT, "
              "img TEXT, "
              "link TEXT, "
              "news TEXT, "
              "transcript TEXT, "
              "year TEXT, "
              "month TEXT, "
              "day TEXT, "
              "imageData TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }
  /// add comics to sqlite database
  Future<void> insertComics(Comics comics) async {
    final Database db = await database;
    await db.insert(
      'comics',
      comics.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  /// get whole list of comics form sqlite database
  Future<List<Comics>> comics() async {
    // Get a reference to the database.
    final Database db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('comics');
    return List.generate(maps.length, (i) {
      return Comics.fromDB(maps[i]);
    });
  }
  /// delete comics from sqlite database
  Future<void> deleteComics(int id) async {
    // Get a reference to the database.
    final db = await database;

    await db.delete(
      'comics',
      where: "num = ?",
      whereArgs: [id],
    );
  }
  ///Check if comics is in sqlite database
  Future<int> checkIfExists(int id) async{
    final db = await database;
    List<Map<String, dynamic>> list = await db.rawQuery('''SELECT EXISTS(SELECT num FROM comics WHERE num="$id" LIMIT 1) as num;''');
    return list[0]['num'];
  }


}