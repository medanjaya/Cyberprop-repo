import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cyberprop/datahelper.dart'; //TODO : cek file ini
import 'package:cyberprop/agen/login.dart';
import 'package:cyberprop/agen/tambah_produk.dart';
import 'package:cyberprop/agen/edit_produk.dart';
import 'package:cyberprop/agen/bottom_nav.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final FirebaseFirestore db = FirebaseFirestore.instance; //TODO : ini di dalam atau luar build?
  String key = '';
  
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser; //TODO : awasi ini
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cyberprop | Marketplace Properti', //TODO : l10n
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
        actions: [
          IconButton(
            onPressed: () async {
              user == null
              ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login()
                ),
              )
              : await FirebaseAuth.instance.signOut().then(
                (value) {
                  setState(() {});
                }
              );
            },
            icon: Icon(
              user == null
              ? Icons.login
              : Icons.logout
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar Item', //TODO : l10n
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: db.collection('property').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final filteredSnapshot = snapshot.data!.docs.where(
                    (e) =>
                      e.get('name').toString().toLowerCase()
                      .contains(
                        key.toLowerCase(),
                      ),
                  )
                  .toList();

                  return ListView.builder(
                    itemCount: filteredSnapshot.length,
                    itemBuilder: (context, i) {
                      final item = filteredSnapshot[i];
                      
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.0,
                              blurRadius: 4.0,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            /*Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: item.get('photo') != null
                              ? Image.memory(
                                  item.get('get')('photo'),
                                  width: 96.0,
                                  height: 96.0,
                                  fit: BoxFit.cover,
                                )
                              : SizedBox(
                                  width: 96.0,
                                  height: 96.0,
                                ),
                            ),*/
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.get('name'),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(item.get('type')),
                                  Text(item.get('address')),
                                  Text(item.get('size-length').toString()),
                                  Text(item.get('size-width').toString()),
                                  Text(item.get('price').toString()),
                                ],
                              ),
                            ),
                            //TODO : conditional nya beda sendiri, perlu diubah?
                            /*if (user != null) IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 168, 86, 86),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProduk(item: item),
                                  ),
                                );
                              },
                            ),*/
                          ],
                        ),
                      );
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return const Center(
                    child: Text('database-error'), //TODO : l10n
                  );
                }
                else {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  );
                }
              }
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
    );
  }
}