import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cyberprop/datahelper.dart';
import 'package:cyberprop/model/model.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  DataHelper dataHelper = DataHelper();
  
  dynamic dropValue; //TODO : cek ini nanti  
  XFile? pickedImage;
  Uint8List? convertedImage;
  
  TextEditingController
  namaController = TextEditingController(),
  alamatController = TextEditingController(),
  panjangController = TextEditingController(),
  lebarController = TextEditingController(),
  deskripsiController = TextEditingController(),
  hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addnewproperty,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                controller: namaController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  pickedImage = pickedFile;
                  
                  File imageFile = File(pickedImage!.path);
                  convertedImage = await imageFile.readAsBytes();

                  setState(() {});
                },
                child: Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                    color: pickedImage != null
                    ? Colors.transparent
                    : Colors.grey[200],
                  ),
                  child: pickedImage != null
                  ? SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.file(
                        File(pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.add),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                value: dropValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                ),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 168, 86, 86),
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropValue = newValue!;
                    }
                  );
                },
                items: <String>[
                  AppLocalizations.of(context)!.houseorshophouse,
                  AppLocalizations.of(context)!.apartementorcondominium,
                  AppLocalizations.of(context)!.villa,
                  AppLocalizations.of(context)!.office,
                  AppLocalizations.of(context)!.estate,
                ]
                .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }
                ).toList(),
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
                controller: alamatController,
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
                      controller: panjangController,
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
                      controller: lebarController,
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
                controller: deskripsiController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
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
                controller: hargaController,
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
                    await dataHelper.insert(
                      Prop(
                        nama: namaController.text,
                        gambar: convertedImage!,
                        tipe: dropValue,
                        alamat: alamatController.text,
                        panjang: int.parse(panjangController.text),
                        lebar: int.parse(lebarController.text),
                        deskripsi: deskripsiController.text,
                        harga: int.parse(hargaController.text),
                      )
                    );
                    if (context.mounted) {
                      Navigator.pop(
                        context,
                        ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.dataupdated
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 168, 86, 86),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.submit,
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
