import 'package:flutter/material.dart';
import 'package:shortcut_comics/models/comics.dart';
import 'package:shortcut_comics/provides/comics_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider with ChangeNotifier{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async{
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'comics_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE dogs("
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

  Future<void> insertComics(Comics comics) async {
    final Database db = await database;
    await db.insert(
      'dogs',
      comics.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Comics>> comics() async {
    // Get a reference to the database.
    final Database db = await database;
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (i) {
      return Comics.fromDB(maps[i]);
    });
  }

  Future<void> deleteComics(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      'dogs',
      where: "num = ?",
      whereArgs: [id],
    );
  }

  Future<int> checkIfExists(int id) async{
    final db = await database;
    List<Map<String, dynamic>> list = await db.rawQuery('''SELECT EXISTS(SELECT num FROM dogs WHERE num="$id" LIMIT 1) as num;''');
    print(list[0]['num']);
    return list[0]['num'];
    //return ;
  }


}