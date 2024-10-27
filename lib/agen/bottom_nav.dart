import 'package:flutter/material.dart';

import 'menu.dart';
import 'kontak.dart';
import 'settings.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.index});
  
  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Contact',
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
      currentIndex: index,
      onTap: (value) {
        Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              if (value == 0) {
                return const Contact();
              }
              else if (value == 1) {
                return const Menu();
              }
              else if (value == 2) {
                return const Settings();
              }
              return context.widget;
            }
          ),
          (Route route) => false
        );      
      },
      backgroundColor: const Color.fromARGB(255, 255, 223, 183),
    );
  }
}