import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cyberprop/agen/login.dart';
import 'package:cyberprop/agen/tambah_produk.dart';
import 'package:cyberprop/agen/edit_produk.dart';

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
    final Map<String, String> languageChange = {
      'house': AppLocalizations.of(context)!.houseorshophouse,
      'condo': AppLocalizations.of(context)!.apartementorcondominium,
      'villa': AppLocalizations.of(context)!.villa,
      'office': AppLocalizations.of(context)!.office,
      'estate': AppLocalizations.of(context)!.estate,
    };

    final User? user = FirebaseAuth.instance.currentUser; //TODO : awasi ini
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.title,
          style: const TextStyle(
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
              : Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.itemlist,
              style: const TextStyle(
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
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: item.get('photo') != null
                              ? Image.network(
                                  item.get('photo'),
                                  width: 96.0,
                                  height: 96.0,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(
                                  width: 96.0,
                                  height: 96.0,
                                  child: Image(
                                    image: AssetImage('assets/logo-new.png'),
                                  ),
                                ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.get('name'),
                                    style: const TextStyle(
                                      color: Colors.black, //TODO : dry code kebawah, yang ada Colors.black nya
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    languageChange[item.get('type')]!,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    item.get('address'),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    item.get('size-length').toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    item.get('size-width').toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    item.get('price').toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            //TODO : conditional nya beda sendiri, perlu diubah?
                            if (user != null) IconButton(
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
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.dataerror),
                  );
                }
                else {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                }
              }
            ),
          ),
        ],
      ),
      floatingActionButton: user != null
      ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Tambah(),
            ),
          );
        },
        child: const Icon(Icons.add),
      )
      : null, //TODO : mencurigakan
    );
  }
}