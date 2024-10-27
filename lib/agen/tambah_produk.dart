import 'dart:io';
import 'dart:typed_data';
import 'package:cyberphobe_project/agen/kontak.dart';
import 'package:cyberphobe_project/agen/settings.dart';
import 'package:cyberphobe_project/datahelper.dart';
import 'package:cyberphobe_project/model/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  DataHelper dataHelper = DataHelper();

  String dropdownValue = 'Rumah/ruko'; // Initial selection for dropdown menu
  XFile? _image; // Declaration for image file
  int _selectedIndex = 0; // Add selected index for BottomNavigationBar

  // Controllers for each TextField
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _panjangController = TextEditingController();
  final TextEditingController _lebarController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Uint8List? _imageToBytes() {
    if (_image != null) {
      return File(_image!.path).readAsBytesSync();
    }
    return null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Kontak()),
        );
        break;
      case 1:
        break; // Tidak perlu navigasi ulang ke halaman yang sama
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Settings()),
        );
        break;
    }
  }

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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: _image != null ? Colors.transparent : Colors.grey[200],
                  ),
                  child: _image != null
                      ? SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.add),
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
                    Uint8List? imageBytes = _imageToBytes();
                    int idproperti = await dataHelper.insert(
                      Prop(
                        nama: _namaController.text,
                        tipe: dropdownValue,
                        alamat: _alamatController.text,
                        panjang: int.parse(_panjangController.text),
                        lebar: int.parse(_lebarController.text),
                        deskripsi: _deskripsiController.text,
                        harga: int.parse(_hargaController.text),
                        gambar: imageBytes ?? Uint8List(0),
                      ),
                    );
                    Navigator.pop(context, true); // Mengirim sinyal refresh
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 167, 86, 86),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'Submit',
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Kontak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Properti',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 167, 86, 86),
      ),
    );
  }
}
