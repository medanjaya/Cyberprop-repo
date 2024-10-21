import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
import 'kontak.dart';
import 'properti.dart';
import 'settings.dart';

//TODO : rencananya, menu untuk klien sama agen di satu file; pakai isAdmin nanti buat pisahkan
bool isAdmin = false;

void checkAuthState(context) {
  FirebaseAuth.instance
  .authStateChanges()
  .listen(
    (User? user) {
      if (user == null) {
        Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
          (Route route) => false
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86), // Warna yang sama
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                checkAuthState(context);
              }
            },
            icon: const Icon(Icons.exit_to_app)
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 223, 183),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo.png'),
                    const Text(
                      'Cyberprop',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Halo, ${FirebaseAuth.instance.currentUser?.email}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
              itemCount: 3, // Ganti dengan jumlah item yang sebenarnya
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16
                  ), // Spasi antar item
                  padding: const EdgeInsets.all(16), // Padding dalam kotak
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Posisi bayangan
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Item ke-$index',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 167, 86, 86),
                        ),
                        onPressed: () {
                          // Tindakan saat ikon edit ditekan
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
        onPressed: () {
          // Tindakan saat tombol tambah ditekan, misalnya menambahkan item baru
          print('Tombol tambah ditekan');
        },
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
        backgroundColor: const Color.fromARGB(255, 255, 223, 183), // Warna latar belakang
      ),
    );
  }
}
