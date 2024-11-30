import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cyberprop/datahelper.dart';
import 'package:cyberprop/agen/login.dart';
import 'package:cyberprop/agen/tambah_produk.dart';
import 'package:cyberprop/agen/edit_produk.dart';
import 'package:cyberprop/agen/bottom_nav.dart';

final user = FirebaseAuth.instance.currentUser;

class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final DataHelper dataHelper = DataHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (user != null) {
                return IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    setState(() {});
                  },
                  icon: const Icon(Icons.logout)
                );
              }
              else {
                return IconButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login()
                      ),
                    );
                  },
                  icon: const Icon(Icons.login)
                );
              }
            },
          ),
          SizedBox(width: 8.0),
          // IconButton(
          //   onPressed: () async {
          //     _loadItems();
          //   },
          //   icon: Icon(Icons.refresh),
          // ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar Item',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List>(
              stream: dataHelper.fetchAsStream(), // Replace with the actual stream method
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items available'));
                }

                final propItem = snapshot.data!;

                return ListView.builder(
                  itemCount: propItem.length,
                  itemBuilder: (context, i) {
                    final item = propItem[i];
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
                          if (item.gambar != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Image.memory(
                                item.gambar,
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
                                  item.nama ?? 'Unknown',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(item.tipe ?? ''),
                                Text(item.alamat ?? ''),
                                Text(item.panjang?.toString() ?? ''),
                                Text(item.lebar?.toString() ?? ''),
                                Text(item.harga?.toString() ?? ''),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Color.fromARGB(255, 167, 86, 86)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProduk(item: item),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Tambah(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(index: 1),
    );
  }
}
