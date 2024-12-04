import 'dart:async';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Prop {
  int? id;
  String nama;
  Uint8List gambar;
  String tipe;
  String alamat;
  int panjang;
  int lebar;
  String deskripsi;
  int harga;

  Prop({
    this.id,
    required this.nama,
    required this.gambar,
    required this.tipe,
    required this.alamat,
    required this.panjang,
    required this.lebar,
    required this.deskripsi,
    required this.harga,
  });

  factory Prop.fromMap(Map<String, dynamic> map) {
    return Prop(
      id: map['id'],
      nama: map['nama'],
      gambar: map['gambar'],
      tipe: map['tipe'],
      alamat: map['alamat'],
      panjang: map['panjang'],
      lebar: map['lebar'],
      deskripsi: map['deskripsi'],
      harga: map['harga'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'gambar': gambar,
      'tipe': tipe,
      'alamat': alamat,
      'panjang': panjang,
      'lebar': lebar,
      'deskripsi': deskripsi,
      'harga': harga,
    };
  }
}

class DataHelper {
  Database? db;
  String dbName = 'PROPERTY_DB';
  int dbVersion = 1;

  final StreamController<List<Prop>> _propStreamController = StreamController<List<Prop>>.broadcast();

  DataHelper() {
    checkDatabase();
    _loadInitialData();
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

  Future<void> _loadInitialData() async {
    await checkDatabase();
    final data = await fetch();
    _propStreamController.add(data);
  }

  Stream<List<Prop>> fetchAsStream() {
    return _propStreamController.stream;
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
    _loadInitialData(); // Reload data after insertion
    return i;
  }

  Future<int> update(Prop data, int id) async {
    int i = await db!.update(
      'Property',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    _loadInitialData(); // Reload data after update
    return i;
  }

  Future<int> delete(int id) async {
    int i = await db!.delete(
      'Property',
      where: 'id = ?',
      whereArgs: [id],
    );
    _loadInitialData(); // Reload data after deletion
    return i;
  }
}