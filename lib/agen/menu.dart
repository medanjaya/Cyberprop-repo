import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../datahelper.dart';
import 'login.dart';
import 'tambah_produk.dart';
import 'edit_produk.dart';
import 'bottom_nav.dart';

//TODO : rencananya, menu untuk klien sama agen di satu file; pakai isAdmin nanti buat pisahkan
bool isAdmin = false;

void checkAuthState(context) {
  FirebaseAuth.instance
  .authStateChanges()
  .listen(
    (User? user) {
      if (user == null) {
        isAdmin = false;
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
  DataHelper dataHelper = DataHelper();
  List propItem = [];

  Future<void> _loadItems() async {
    List items = await dataHelper.fetch();
    setState(
      () {
        propItem = items;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
        actions: [
          Builder(
            builder: (context) {
              if (isAdmin) {
                return IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      checkAuthState(context);
                    }
                    setState(
                      () {
                        //TODO : hapus nanti
                      }
                    );
                  },
                  icon: const Icon(Icons.logout)
                );
              }
              else {
                return IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
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
            }
          ),
          IconButton(
            onPressed: () async {
              _loadItems();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
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
              itemCount: propItem.length,
              itemBuilder: (context, index) {
                var item = propItem[index];
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
                      // if (item['imagePath'] != null)
                      //   Padding(
                      //     padding: const EdgeInsets.only(right: 16.0),
                      //     child: Image.file(
                      //       File(item['imagePath']),
                      //       width: 100,
                      //       height: 100,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
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
                            Text(item.panjang.toString()),
                            Text(item.lebar.toString()),
                            Text(item.harga.toString()),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 167, 86, 86),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProduk(item: item),
                            ),
                          )
                          .then(
                            (_) {
                              _loadItems();
                            }
                          );
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
