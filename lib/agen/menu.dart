import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
import 'kontak.dart';
import 'properti.dart';
import 'settings.dart';
import 'tambah_produk.dart';

//TODO : rencananya, menu untuk klien sama agen di satu file; pakai isAdmin nanti buat pisahkan
bool isAdmin = false;

void checkAuthState(context) {
  FirebaseAuth.instance
  .authStateChanges()
  .listen(
    (User? user) {
      if (user == null) {
        /*Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
          (Route route) => false
        );*/
      }
      else {
        //TODO : mau isi apa ya?
      }
    },
  );
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> itemList = []; 

  final List<Widget> pages = const [
    Kontak(),
    Properti(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        selectedIndex = index;
      }
    );
  }

   Future<void> _addItem() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Tambah(),
      ),
    );

    if (newItem != null) {
      setState(() {
        itemList.add(newItem); // Menambahkan item baru ke dalam list
      });
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Daftar Item',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length, // Menggunakan panjang itemList
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
        onPressed: _addItem, // Panggil fungsi _addItem
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