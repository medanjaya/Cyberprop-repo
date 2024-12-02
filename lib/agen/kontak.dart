import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cyberprop/agen/bottom_nav.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.agentcontact),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.contactlist,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildContactTile(
                  'WhatsApp',
                  FontAwesomeIcons.whatsapp,
                  'https://wa.me/6289613713685?text=Test%20Message', //TODO : sebelum publish, ganti kontaknya yang bener
                ),
                _buildContactTile(
                  'Instagram',
                  FontAwesomeIcons.instagram,
                  'https://www.instagram.com/nicolasleeproperty?igsh=MWhheGhiaWJ4d2hwOQ==',
                ),
                _buildContactTile(
                  'Facebook',
                  FontAwesomeIcons.facebook,
                  'https://www.facebook.com/share/MNe7fKiLNFdLXWbQ/?mibextid=qi2Omg',
                ),
                _buildContactTile(
                  'Tiktok',
                  FontAwesomeIcons.tiktok,
                  'https://vm.tiktok.com/ZMh9MSeVm/',
                ),
              ],
            ), 
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(String title, IconData icon, String url) {
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: FaIcon(
          icon,
          size: 32.0,
          color: const Color.fromARGB(255, 168, 86, 86),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () async {
          await launchUrl(
            Uri.parse(url),
          );
        },
      ),
    );
  }
}
