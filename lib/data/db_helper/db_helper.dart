import 'dart:io';

import 'package:github/data/model/db_user_model.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  late Database _database;

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Github.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, type TEXT,avatar TEXT)');
    });
  }

  insertData(DBUserModel dbUserModel) async {
    final db = await database;
    var res = await db.insert("user", dbUserModel.toJson());
    print('insert $res');
    return res;
  }

  Future<List<DBUserModel>> getAllUsers() async {
    final db = await database;
    var res = await db.query("user");
    List<DBUserModel> list =
        res.isNotEmpty ? res.map((c) => DBUserModel.fromMap(c)).toList() : [];
    print('list ${list.toString()}');
    return list;
  }
}
