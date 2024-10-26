import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Tambahkan ini

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
                  FontAwesomeIcons.whatsapp, // Gunakan FontAwesome untuk WhatsApp
                  'https://wa.me/0123456789', // Ganti dengan nomor WhatsApp yang sesuai
                ),
                _buildContactTile(
                  context,
                  'Instagram',
                  FontAwesomeIcons.instagram, // Gunakan FontAwesome untuk Instagram
                  'https://www.instagram.com/username/', // Ganti dengan username Instagram yang sesuai
                ),
                _buildContactTile(
                  context,
                  'Facebook',
                  FontAwesomeIcons.facebook, // Gunakan FontAwesome untuk Facebook
                  'https://www.facebook.com/username/', // Ganti dengan username Facebook yang sesuai
                ),
                _buildContactTile(
                  context,
                  'X',
                  FontAwesomeIcons.x, // Gunakan FontAwesome untuk X (Twitter)
                  'https://twitter.com/username/', // Ganti dengan username X yang sesuai
                ),
              ],
            ),
          ),
        ],
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
