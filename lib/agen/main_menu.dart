import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cyberprop/agen/menu.dart';
import 'package:cyberprop/agen/kontak.dart';
import 'package:cyberprop/agen/settings.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int i = 1;
  Widget currentMenu = Menu();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(child: currentMenu),
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
        onTap: (value) { //TODO : dry code; pake key-pair
          if (value == 0) {
            currentMenu = Contact();
          }
          else if (value == 1) {
            currentMenu = Menu();
          }
          else if (value == 2) {
            currentMenu = Settings();
          }
          i = value;
          setState(() {});
        },
        currentIndex: i,
        backgroundColor: const Color.fromARGB(255, 255, 225, 185),
      ),
    );
  }
}