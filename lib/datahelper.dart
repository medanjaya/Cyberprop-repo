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
    return data.map(
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
  }

  Future<int> insert(Prop data) async {
    int i = await db!.insert(
      'Property', {
        'id': data.id,
        'nama': data.nama,
        'gambar': data.gambar,
        'tipe': data.tipe,
        'alamat': data.alamat,
        'panjang': data.panjang,
        'lebar': data.lebar,
        'deskripsi': data.deskripsi,
        'harga': data.harga
      }
    );
    return i;
  }

  Future<int> update(Prop data, int id) async {
    int i = await db!.update(
      'Property',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return i;
  }

  Future<int> delete(int id) async {
    int i = await db!.delete(
      'Property',
      where: 'id = ?',
      whereArgs: [id],
    );
    return i;
  }
}
