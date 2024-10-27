import 'package:cyberphobe_project/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';

class DataHelper {
  Database? database;
  String DATABASE_NAME = "PROPERTY_DB"; // Renamed to fit your model context
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
      join(path, DATABASE_NAME),
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

  // Fetch all properties
  Future<List<Prop>> fetch() async {
    List data = await database!.query("Property");
    List<Prop> proper = data.map((e) => Prop(nama: e['nama'], gambar: e['gambar'], tipe: e['tipe'], alamat: e['alamat'], panjang: e['panjang'], lebar: e['lebar'], deskripsi: e['deskripsi'], harga: e['harga']),).toList();
    return proper;
  }

  // Insert a new property
  Future<int> insert(Prop prop) async {
    int idproperti = await database!.insert("Property", {
      "id": prop.id,
      "nama": prop.nama,
      "gambar": prop.gambar,
      "tipe": prop.tipe,
      "alamat": prop.alamat,
      "panjang": prop.panjang,
      "lebar": prop.lebar,
      "deskripsi": prop.deskripsi,
      "harga": prop.harga
    });
    return idproperti;
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
