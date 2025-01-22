import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cyberprop/agen/login.dart';
import 'package:cyberprop/agen/menu.dart';
import 'package:cyberprop/agen/kontak.dart';
import 'package:cyberprop/agen/settings.dart';
import 'package:cyberprop/agen/tambah_produk.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int i = 1;
  Widget currentMenu = const Menu();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            if (i == 0) {
              return Text(
                AppLocalizations.of(context)!.agentcontact,
                style: const TextStyle(color: Colors.white),
              );
            }
            else if (i == 1) {
              return Text(
                AppLocalizations.of(context)!.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
              );
            }
            else if (i == 2) {
              return Text(
                AppLocalizations.of(context)!.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
              );
            }
            else {
              return Text(
                AppLocalizations.of(context)!.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
                ),
              );
            }
          },
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
      body: currentMenu,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: AppLocalizations.of(context)!.contact,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.business),
            label: AppLocalizations.of(context)!.property,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            currentMenu = const Contact();
          }
          else if (value == 1) {
            currentMenu = const Menu();
          }
          else if (value == 2) {
            currentMenu = const Settings();
          }
          i = value;
          setState(() {});
        },
        currentIndex: i,
        backgroundColor: const Color.fromARGB(255, 255, 225, 185),
      ),
      floatingActionButton: i == 1 && user != null
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
      : null,
    );
  }
}