import 'dart:typed_data'; //TODO : pindahkan ke datahelper

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
