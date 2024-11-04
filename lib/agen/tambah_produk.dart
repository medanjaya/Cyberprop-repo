import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../datahelper.dart';
import '../model/model.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  DataHelper dataHelper = DataHelper();
  
  String dropValue = 'Rumah/ruko';
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
        title: const Text(
          'Tambah Properti Baru',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nama Properti',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
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
                  color: Color.fromARGB(255, 167, 86, 86),
                ),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 167, 86, 86),
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropValue = newValue!;
                    }
                  );
                },
                items: <String>[
                  'Rumah/ruko',
                  'Apartemen/kondominium',
                  'Villa',
                  'Kantor',
                  'Tanah',
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
              const Text(
                'Alamat',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: alamatController,
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
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: panjangController,
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
                      controller: lebarController,
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
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
                  border: InputBorder.none,
                ),
              ),
              const Text(
                'Harga',
                style: TextStyle(
                  color: Color.fromARGB(255, 167, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: hargaController,
                decoration: const InputDecoration(
                  prefixText: 'Rp ',
                  filled: true,
                  fillColor: Color.fromARGB(255, 233, 239, 214),
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
                              'Data updated.'
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 167, 86, 86),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
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
