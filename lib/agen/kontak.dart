import 'package:cyberphobe_project/agen/settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Tambahkan ini
import 'menu.dart'; // Pastikan Anda mengimpor Menu

class Kontak extends StatelessWidget {
  const Kontak({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak'),
        backgroundColor: const Color.fromARGB(255, 167, 86, 86),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Daftar Kontak',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildContactTile(
                  context,
                  'WhatsApp',
                  FontAwesomeIcons.whatsapp,
                  'https://wa.me/0123456789', // Ganti dengan nomor WhatsApp yang sesuai
                ),
                _buildContactTile(
                  context,
                  'Instagram',
                  FontAwesomeIcons.instagram,
                  'https://www.instagram.com/username/', // Ganti dengan username Instagram yang sesuai
                ),
                _buildContactTile(
                  context,
                  'Facebook',
                  FontAwesomeIcons.facebook,
                  'https://www.facebook.com/username/', // Ganti dengan username Facebook yang sesuai
                ),
                _buildContactTile(
                  context,
                  'X',
                  FontAwesomeIcons.x,
                  'https://twitter.com/username/', // Ganti dengan username X yang sesuai
                ),
              ],
            ),
          ),
        ],
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
        currentIndex: 0, // Set current index as needed
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
        backgroundColor: const Color.fromARGB(255, 255, 223, 183),
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, String title, IconData icon, String url) {
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
      child: ListTile(
        leading: FaIcon(icon, color: const Color.fromARGB(255, 167, 86, 86)), // Gunakan FaIcon untuk FontAwesome
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}
