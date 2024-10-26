import 'package:cyberphobe_project/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';

class DataHelper {
  Database? database;
  String TABLE_NAME = "PROPERTY_DB"; // Renamed to fit your model context
  int databaseVersion = 1;

  DataHelper() {
    checkDatabase();
  }

  Future<Database> checkDatabase() async {
    if (database == null) {
      database = await initDatabase();
    }
    return database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, TABLE_NAME),
      version: databaseVersion,
      onCreate: createDatabase,
    );
  }

  Future<void> createDatabase(Database database, int version) async {
    await database.execute(
        '''CREATE TABLE Property (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT,
          gambar BLOB,
          tipe TEXT,
          alamat TEXT,
          panjang INTEGER,
          lebar INTEGER,
          deskripsi TEXT,
          harga INTEGER
        )'''); // Adjusted to match the `prop` class
  }
  Future<int> insertProp(Prop prop) async {
    final db = await checkDatabase();
    return await db.insert(
      TABLE_NAME,
      prop.toMap(), // Use the model's toMap function
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  // Fetch all properties
  Future<List<Prop>> getProps() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db!.query('properties');

    return List.generate(maps.length, (i) {
      return Prop(
        id: maps[i]['id'],
        nama: maps[i]['nama'],
        tipe: maps[i]['tipe'],
        alamat: maps[i]['alamat'],
        panjang: maps[i]['panjang'],
        lebar: maps[i]['lebar'],
        deskripsi: maps[i]['deskripsi'],
        harga: maps[i]['harga'],
        gambar: maps[i]['gambar'],
      );
    });
  }


  // Update an existing property
  Future<int> update(Prop property, int id) async {
    int rowsAffected = await database!.update(
      "Property",
      property.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
    return rowsAffected;
  }

  // Delete a property
  Future<int> delete(int id) async {
    int rowsAffected = await database!.delete(
      "Property",
      where: "id = ?",
      whereArgs: [id],
    );
    return rowsAffected;
  }
}
