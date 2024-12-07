import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cyberprop/datahelper.dart';

class EditProduk extends StatefulWidget {
  const EditProduk({super.key, required this.item});

  final dynamic item; //TODO : ubah ini

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
        title: Text(AppLocalizations.of(context)!.editproduct),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.propertyname,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86)
                ),
                underline: Container(
                  height: 2.0,
                  color: const Color.fromARGB(255, 168, 86, 86),
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropdownValue = newValue!;
                    }
                  );
                },
                items: <String>[
                  AppLocalizations.of(context)!.houseorshophouse,
                  AppLocalizations.of(context)!.apartementorcondominium,
                  AppLocalizations.of(context)!.villa,
                  AppLocalizations.of(context)!.office,
                  AppLocalizations.of(context)!.estate
                ]
                .map(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                )
                .toList(),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.address,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.size,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _panjangController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.length,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 240, 215),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _lebarController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.width,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 240, 215),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.description,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.price,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  prefixText: 'Rp. ',
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await dataHelper.update(
                      Prop(
                        id: widget.item.id,
                        nama: _namaController.text,
                        alamat: _alamatController.text,
                        panjang: int.parse(_panjangController.text),
                        lebar: int.parse(_lebarController.text),
                        deskripsi: _deskripsiController.text,
                        harga: int.parse(_hargaController.text),
                        gambar: Uint8List(0), //TODO : urus ini
                        tipe: dropdownValue,
                      ),
                      widget.item.id ?? 0,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 168, 86, 86),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.update,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
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