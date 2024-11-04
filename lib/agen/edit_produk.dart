import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../datahelper.dart';
import '../model/model.dart';

class EditProduk extends StatefulWidget {
  const EditProduk({super.key, required this.item});

  final Prop item; // Menerima item yang akan diedit

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final DataHelper dataHelper = DataHelper();

  String dropdownValue = '';
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _panjangController = TextEditingController();
  final TextEditingController _lebarController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    dropdownValue = widget.item.tipe ;
    _namaController.text = widget.item.nama;
    _alamatController.text = widget.item.alamat;
    _panjangController.text = widget.item.panjang.toString();
    _lebarController.text = widget.item.lebar.toString();
    _deskripsiController.text = widget.item.deskripsi;
    _hargaController.text = widget.item.harga.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama Properti',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Color.fromARGB(255, 167, 86, 86)),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 167, 86, 86),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Rumah/ruko',
                  'Apartemen/kondominium',
                  'Villa',
                  'Kantor',
                  'Tanah'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Alamat',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ukuran Properti',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _panjangController,
                      decoration: const InputDecoration(
                        labelText: 'Panjang (meter)',
                        filled: true,
                        fillColor: Color.fromARGB(255, 233, 239, 214),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _lebarController,
                      decoration: const InputDecoration(
                        labelText: 'Lebar (meter)',
                        filled: true,
                        fillColor: Color.fromARGB(255, 233, 239, 214),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Deskripsi',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Harga',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await dataHelper.update(
                      Prop(
                        id: widget.item.id, // Pastikan ID tetap
                        nama: _namaController.text,
                        alamat: _alamatController.text,
                        panjang: int.parse(_panjangController.text),
                        lebar: int.parse(_lebarController.text),
                        deskripsi: _deskripsiController.text,
                        harga: int.parse(_hargaController.text),
                        gambar: Uint8List(0),
                        tipe: dropdownValue,
                      ),
                      widget.item.id ?? 0, 
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 167, 86, 86),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}