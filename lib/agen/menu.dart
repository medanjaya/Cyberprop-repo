import 'dart:typed_data';

import 'package:cyberphobe_project/model/model.dart';
import 'package:cyberphobe_project/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'kontak.dart';
import 'settings.dart';
import 'tambah_produk.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> itemList = [];

  @override
  void initState() {
    super.initState();
    _loadItems(); // Load items when the menu is initialized
  }

  Future<void> _loadItems() async {
    DataHelper dataHelper = DataHelper();
    List<Prop> props = await dataHelper.getProps();
    setState(() {
      itemList = props.map((prop) => {
        'nama': prop.nama,
        'tipe': prop.tipe,
        'alamat': prop.alamat,
        'ukuran': prop.panjang * prop.lebar,
        'deskripsi': prop.deskripsi,
        'harga': prop.harga,
        'imagePath': prop.gambar != null ? prop.gambar.toString() : null,
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Kontak()),
        );
        break;
      case 1:
        // No need to navigate to the same Menu page
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
    }
  }

  Future<void> _addItem() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Tambah(),
      ),
    );

    if (newItem != null) {
      DataHelper dataHelper = DataHelper();
      // Create a Prop instance
      Prop newProp = Prop(
        nama: newItem['nama'],
        tipe: newItem['tipe'],
        alamat: newItem['alamat'],
        panjang: newItem['panjang'],
        lebar: newItem['lebar'],
        deskripsi: newItem['deskripsi'],
        harga: int.parse(newItem['harga']),
        gambar:  Uint8List.fromList(await File(newItem['imagePath']).readAsBytes()),
      );
      await dataHelper.insertProp(newProp); // Insert into the database
      _loadItems(); // Reload the items from the database
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar Item',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (item['imagePath'] != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Image.file(
                            File(item['imagePath']),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nama'] ?? 'Unknown',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(item['tipe'] ?? ''),
                            Text(item['alamat'] ?? ''),
                            Text(item['ukuran'] ?? ''),
                            Text(item['harga'] ?? ''),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 167, 86, 86),
                        ),
                        onPressed: () {
                          print('Edit Item ke-$index');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
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
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 255, 223, 183),
      ),
    );
  }
}
