// Singleton DatabaseProvider

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_list/models/user_model.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider._();
  DatabaseProvider._();
  factory DatabaseProvider() => dbProvider;

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _createDatabase();
    return _database;
  }

  _createDatabase() async {
    if (kDebugMode) {
      print('Database Created');
    }
    return openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, email TEXT)",
        );
      },
      version: 1,
    );
  }

  //insert user list to database
  Future insertUsers(List<User> users) async {
    Database? db = await database;
    final batch = db!.batch();
    for (User user in users) {
      batch.insert('User', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  //get User list from database in ascending order
  Future<List<User>> getUsers() async {
    if (kDebugMode) {
      print('fetching users from local database');
    }
    Database? db = await database;

    // SQLite Query to fetch data from User table ordered by name in ascending order
    final List<Map<String, dynamic>> maps = await db!.query('User', orderBy: 'name ASC');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }

  //search user from database by name
  Future<List<User>> searchUsersByName(String name) async {
    if (kDebugMode) {
      print('searching user from local database');
    }
    Database? db = await database;

    // SQLite Query to fetch data from User table ordered by name in ascending order
    final List<Map<String, dynamic>> maps =
        await db!.query('User', where: 'name LIKE ?', whereArgs: ['%$name%'], orderBy: 'name ASC');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }
}
