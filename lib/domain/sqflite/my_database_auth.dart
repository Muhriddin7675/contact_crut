import 'dart:async';

import 'package:flutter_contact_sqflite/data/model/auth_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabaseAuth {
  static int version = 1;
  static String dbName = 'Contacts.dp';
  static String contactTableAuth = "Auth";

  Future<Database> _getDb() async {
    return await openDatabase(join(await getDatabasesPath(), dbName),
        version: version,
        singleInstance: true,
        onCreate: (db, version) =>
            db.execute('''CREATE TABLE $contactTableAuth (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL)'''));
  }

  Future<bool> insertUser(AuthData user) async {
    try {
      final db = await _getDb();
      await db.insert(contactTableAuth, user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getUser(AuthData user) async {
    final db = await _getDb();
    List<Map<String, dynamic>> result = await db
        .query(contactTableAuth, where: 'email = ?', whereArgs: [user.email]);
    if (result.isNotEmpty) {
      var emailInPassword = AuthData.fromJson(result.first);
      if (emailInPassword.password == user.password) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
