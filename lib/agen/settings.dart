import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lightdark_provider.dart';
import 'bottom_nav.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LightDarkProvider>(context);
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
                  value: provider.enableDarkMode,
                  activeColor: const Color.fromARGB(255, 99, 185, 255),
                  onChanged: (e) {
                    setState(() {
                      provider.setBrightness = e;
                    });
                  },
                ),
              ],
            ),
            // Add more settings options here
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(index: 2),
    );
  }
}