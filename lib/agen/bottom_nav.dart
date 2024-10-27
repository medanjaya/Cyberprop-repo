import 'package:flutter/material.dart';

import 'menu.dart';
import 'kontak.dart';
import 'settings.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.i});
  final int i;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: i,
      onTap: (value) {
        Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) {
              if (value == 0) {
                return const Kontak();
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

/*void _onItemTapped(int index) {
  setState(() {
    //selectedIndex = index;
  });

  switch (index) { //TODO : cek ini nanti
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Kontak()),
      );
      break;
    case 1:
      // No need to navigate to the same Menu page
      break;
    case 2:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Settings()),
      );
      break;
  }
}

onTap: (index) {
          switch (index) {
            case 0: // Kontak
              // Already on Kontak screen
              break;
            case 1: // Navigate to Menu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Menu()),
              );
              break;
            case 2: // Navigate to Settings or another screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
              break;
          }
        },
*/