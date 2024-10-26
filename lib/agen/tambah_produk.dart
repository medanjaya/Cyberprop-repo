import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  String dropdownValue = 'Rumah/ruko'; // Initial selection for dropdown menu
  XFile? _image; // Declaration for image file
  int _selectedIndex = 0; // Add selected index for BottomNavigationBar

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
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
                  onPressed: () {
  Map<String, dynamic> newItem = {
    'nama': 'Nama Properti', // Ganti sesuai dengan data yang diinput
    'tipe': dropdownValue,
    'alamat': 'Alamat Properti',
    'ukuran': '20x30', // contoh ukuran
    'harga': 'Rp 100.000.000',
    'imagePath': _image?.path
  };

  Navigator.pop(context, newItem); // Mengembalikan data ke halaman sebelumnya
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
        backgroundColor: const Color.fromARGB(255, 255, 223, 183),
      ),
    );
  }
}
