import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/model.dart';

class DataHelper {
  Database? db;
  String dbName = 'PROPERTY_DB';
  int dbVersion = 1;

  DataHelper() {
    checkDatabase();
  }

  Future<Database> checkDatabase() async {
    db ??= await initDatabase();
    return db!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, dbName),
      version: dbVersion,
      onCreate: createDatabase,
    );
  }

  Future<void> createDatabase(Database db, int version) async {
    await db.execute(
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
        )
      '''
    );
  }

  Future<List<Prop>> fetch() async {
    List data = await db!.query('Property');
    List<Prop> proper = data.map(
      (e) => Prop(
        id: e['id'],
        nama: e['nama'],
        gambar: e['gambar'],
        tipe: e['tipe'],
        alamat: e['alamat'],
        panjang: e['panjang'],
        lebar: e['lebar'],
        deskripsi: e['deskripsi'],
        harga: e['harga']
      ),
    ).toList();
    
    return proper;
  }

  Future<int> insert(Prop prop) async {
    int idproperti = await db!.insert('Property', {
      'id': prop.id,
      'nama': prop.nama,
      'gambar': prop.gambar,
      'tipe': prop.tipe,
      'alamat': prop.alamat,
      'panjang': prop.panjang,
      'lebar': prop.lebar,
      'deskripsi': prop.deskripsi,
      'harga': prop.harga
    });
    return idproperti;
  }

  Future<int> update(Prop prop, int id) async {
    int rowsAffected = await db!.update(
      'Property',
      prop.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return rowsAffected;
  }

  Future<int> delete(int id) async {
    int rowsAffected = await db!.delete(
      'Property',
      where: 'id = ?',
      whereArgs: [id],
    );
    return rowsAffected;
  }
}
