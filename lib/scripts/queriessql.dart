import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../persistence/clientUpdate_model.dart';
import '../persistence/client_model.dart';

class DBHelper {
  static Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'butterpopcorn.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE IF NOT EXISTS Users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            password TEXT,
            email TEXT,
            imagem TEXT
          )
        ''');
      },
      version: 1,
    );
    return database;
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

  static Future<void> updateUserId(UserUpdateModel user, int id ) async {
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
