import 'package:cyberphobe_project/agen/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cyberphobe_project/agen/kontak.dart'; // Import the Kontak page
import 'package:cyberphobe_project/agen/menu.dart'; // Import the Menu (Properti) page

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 2; // Default to the Settings page

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    switch (index) {
      case 0: // Navigate to Kontak
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Kontak()),
        );
        break;
      case 1: // Navigate to Menu (Properti)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Menu()),
        );
        break;
      case 2: // Already on Settings screen, no action needed
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pengaturan Aplikasi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Light / Dark Mode Theme'),
                Switch(
                  value: prov.enableDarkMode,
                  activeColor: const Color.fromARGB(255, 99, 185, 255),
                  onChanged: (e) {
                    setState(() {
                      prov.setBrightness = e;
                    });
                  },
                ),
              ],
            ),
            // Add more settings options here
          ],
        ),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Call the navigation method
        backgroundColor: const Color.fromARGB(255, 255, 223, 183),
      ),
    );
  }
}
