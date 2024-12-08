import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:cyberprop/agen/access_cam.dart';

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  final FirebaseFirestore db = FirebaseFirestore.instance; //TODO : ini di dalam atau luar build?
  final Reference storeRef = FirebaseStorage.instance.ref();
  
  dynamic dropValue;
  dynamic storeRefUrl; //TODO : cek ini dua dynamic nanti
  XFile? pickedImage;
  
  TextEditingController
  namaController = TextEditingController(),
  alamatController = TextEditingController(),
  panjangController = TextEditingController(),
  lebarController = TextEditingController(),
  deskripsiController = TextEditingController(),
  hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, String> languageChange = {
      'house': AppLocalizations.of(context)!.houseorshophouse,
      'condo': AppLocalizations.of(context)!.apartementorcondominium,
      'villa': AppLocalizations.of(context)!.villa,
      'office': AppLocalizations.of(context)!.office,
      'estate': AppLocalizations.of(context)!.estate,
    };
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addnewproperty,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.propertyname,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        pickedImage = pickedFile;
                        
                        if (pickedImage != null) {
                          final imageFile = File(pickedImage!.path);
                          final newStoreRef = storeRef.child(pickedImage!.name);
                          
                          //TODO : masalahnya disini, ga jadi submit pun gambarnya udah ter-upload duluan
                          try {
                            await newStoreRef.putFile(imageFile).whenComplete(
                              () async {
                                storeRefUrl = await newStoreRef.getDownloadURL();
                              }
                            );
                          }
                          on FirebaseException catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!.imagefail + e.toString()),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                          setState(() {});
                        }
                        else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!.noimage),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 96.0,
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
                  ),
                  IconButton(
                    onPressed: () async { //TODO : dry code kebawah
                      if (await Permission.camera.status.isGranted) {
                        final shotImage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccessCamera(),
                            ),
                          );
                          
                          final imageFile = File(shotImage!.path);
                          final newStoreRef = storeRef.child('shotImage${shotImage.hashCode.toString()}.jpg'); //TODO : ubah ini
                          
                          try {
                            await newStoreRef.putFile(imageFile).whenComplete(
                              () async {
                                storeRefUrl = await newStoreRef.getDownloadURL();
                                pickedImage = shotImage;
                                setState(() {});
                              }
                            );
                          }
                          on FirebaseException catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!.imagefail + e.toString()),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                      }
                      else {
                        final status = await Permission.camera.request();

                        if (status == PermissionStatus.granted) {
                          final shotImage = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccessCamera(),
                            ),
                          );
                          
                          final imageFile = File(shotImage!.path);
                          final newStoreRef = storeRef.child('shotImage${shotImage.hashCode.toString()}.jpg'); //TODO : ubah ini
                          
                          try {
                            await newStoreRef.putFile(imageFile).whenComplete(
                              () async {
                                storeRefUrl = await newStoreRef.getDownloadURL();
                                pickedImage = shotImage;
                                setState(() {});
                              }
                            );
                          }
                          on FirebaseException catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!.imagefail + e.toString()),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                        else if (status == PermissionStatus.permanentlyDenied) {
                          openAppSettings();
                        }
                      }
                    },
                    icon: const Icon(Icons.camera_alt_outlined)
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              DropdownButton<String>(
                value: dropValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                ),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 168, 86, 86),
                ),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropValue = newValue!;
                    }
                  );
                },
                items: <String>[
                  'house',
                  'condo',
                  'villa',
                  'office',
                  'estate'
                ]
                .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(languageChange[value]!),
                    );
                  }
                ).toList(),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.address,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.size,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: panjangController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.length,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 240, 215),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: lebarController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.width,
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 240, 215),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)!.description,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.price,
                style: const TextStyle(
                  color: Color.fromARGB(255, 168, 86, 86),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: hargaController,
                decoration: const InputDecoration(
                  prefixText: 'Rp. ',
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 240, 215),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    db.collection('property')
                    .add(
                      {
                        'address': alamatController.text,
                        'desc': deskripsiController.text,
                        'location': const GeoPoint(0.0, 0.0), //TODO : nanti kita kejar abang Yap masalah ini
                        'name': namaController.text,
                        'photo': storeRefUrl, //TODO : ini juga
                        'price': int.parse(hargaController.text),
                        'size-length': int.parse(panjangController.text),
                        'size-width': int.parse(lebarController.text),
                        'type': dropValue,
                      }
                    );
                    if (context.mounted) {
                      Navigator.pop(
                        context,
                        ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.dataupdated
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 168, 86, 86),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: const TextStyle(
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
