import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../persistence/clientUpdate_model.dart';
import '../persistence/client_model.dart';
import '../persistence/movie_model.dart';

class DBHelper {
  static Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'butterpopcorn.db'),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS Users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            password TEXT,
            email TEXT,
            imagem TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE IF NOT EXISTS Favs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idIMDB TEXT,
            title TEXT,
            fulltitle TEXT,
            rating REAL,
            image TEXT,
            releasedate TEXT,
            year TEXT,
            genres TEXT,
            plot TEXT,
            directors TEXT,
            actors TEXT,
            runtime TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE IF NOT EXISTS Seen (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idIMDB TEXT,
            title TEXT,
            fulltitle TEXT,
            rating REAL,
            image TEXT,
            releasedate TEXT,
            year TEXT,
            genres TEXT,
            plot TEXT,
            directors TEXT,
            actors TEXT,
            runtime TEXT
          )
        ''');
        return db;
      },
      version: 4,
    );
    return database;
  }

  static Future<List<Map<String, dynamic>>> getFavs() async {
    var database = await DBHelper.database();
    final db = database;

    List<Map<String, dynamic>> maps = await db.query('Favs');

    return maps;
  }

  static Future<List<Map<String, dynamic>>> getSeen() async {
    var database = await DBHelper.database();
    final db = database;

    List<Map<String, dynamic>> maps = await db.query('Seen');

    return maps;
  }

  static Future<void> insertFavMovie(MovieModel movieModel) async {
    try {
      var database = await DBHelper.database();
      final db = database;

      await db.insert(
        'Favs',
        movieModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      List<Map<String, dynamic>> maps = await db.query('Favs');
      print('Total records: ${maps.length}');
      print('Records: $maps');
    } catch (e) {
      print('Error inserting record: $e');
    }
  }

  static Future<void> insertSeenMovie(MovieModel movieModel) async {
    try {
      var database = await DBHelper.database();
      final db = database;

      await db.insert(
        'Seen',
        movieModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      List<Map<String, dynamic>> maps = await db.query('Seen');
      print('Total records: ${maps.length}');
      print('Records: $maps');
    } catch (e) {
      print('Error inserting record: $e');
    }
  }

  static Future<void> deleteFmovie(String id) async {
    var database = DBHelper.database();
    final db = await database;

    await db.delete(
      'Favs',
      where: 'idIMDB = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteSmovie(String id) async {
    var database = DBHelper.database();
    final db = await database;

    await db.delete(
      'Seen',
      where: 'idIMDB = ?',
      whereArgs: [id],
    );
  }

  static Future<void> insertUser(UsersModel usersModel) async {
    // Get a reference to the database.
    var database = await DBHelper.database();
    final db = database;

    await db.insert(
      'Users',
      usersModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateUser(UserUpdateModel user) async {
    var database = DBHelper.database();
    final db = await database;

    await db.update(
      'Users',
      user.toMap(),
      where: 'nome = ?',
      whereArgs: [user.nome],
    );
  }

  static Future<void> updateUserId(UserUpdateModel user, int id) async {
    var database = DBHelper.database();
    final db = await database;

    await db.update(
      'Users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteUser(int id) async {
    var database = DBHelper.database();
    final db = await database;

    await db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map> getTodo(int id) async {
    var database = DBHelper.database();
    final db = await database;

    List<Map> maps = await db.query('Users',
        columns: ['name'], where: 'name = ?', whereArgs: [id]);

    return maps.first;
  }
}
