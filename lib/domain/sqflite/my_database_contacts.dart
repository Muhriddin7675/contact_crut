import 'package:flutter_contact_sqflite/data/model/contact_data.dart';
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';

class MyDatabaseContacts {

  static int version = 1;
  static String dbName = 'Contacts.db';
  static String contactTableName = "Contact";

  Future<Database> _getDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: version,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $contactTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phoneNumber TEXT)');
      },
    );
  }

  Future<bool> addContact(ContactData data) async {
    print("Muhriddin" + data.phoneNumber);
    try {
      final db = await _getDb();
      await db.insert(contactTableName, data.toJson());
      return true;
    } catch (e) {
      print('Error adding contact: $e');
      return false;
    }
  }

  Future<List<ContactData>> getAllUser() async {
    final db = await _getDb();
    final map = await db.query(contactTableName);

    print("maps $map");
    try {
      return List.generate(
          map.length, (index) => ContactData.fromJson(map[index]));
    } catch (e) {
      return [];
    }
  }

/*  Future<List<ContactData>> getAllContact() async {
    try {
      final db = await _getDb();
      var map = await db.query(contactTableName);
      return List.generate(map.length, (index) => ContactData.fromJson(map[index]));
    } catch (e) {
      print('Error getting all contacts: $e');
      return [];
    }
  }*/
  Future<List<ContactData>> getAllContact() async {
    try {
      final db = await _getDb();
      var maps = await db.query(contactTableName);
      print(maps.length);
      return [
        for (final {
              'id': id as int,
              'name': name as String,
              'phoneNumber': phoneNumber as String,
            } in maps)
          ContactData(id: id, name: name, phoneNumber: phoneNumber),
      ];
    } catch (e) {
      print('Error getting all contacts: $e');
      return [];
    }
  }

  Future<void> updateContact(ContactData data) async {
    try {
      final db = await _getDb();
      await db.update(contactTableName, data.toJson(),
          where: 'id = ?', whereArgs: [data.id]);
    } catch (e) {
      print('Error updating contact: $e');
    }
  }

  Future<void> deleteContact(int id) async {
    try {
      final db = await _getDb();
      await db.delete(contactTableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting contact: $e');
    }
  }
}
