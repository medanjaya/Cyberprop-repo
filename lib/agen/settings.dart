import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cyberprop/agen/bottom_nav.dart';
import 'package:cyberprop/provider/lightdark_provider.dart';
import 'package:cyberprop/provider/language_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LightDarkProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        backgroundColor: const Color.fromARGB(255, 168, 86, 86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.appsettings,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.lightdarktheme),
                Switch(
                  value: themeProvider.enableDarkMode,
                  activeColor: const Color.fromARGB(255, 100, 185, 255),
                  onChanged: (e) {
                    setState(
                      () {
                        themeProvider.setBrightness = e;
                      }
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Language/Bahasa'),
                DropdownButton<String>(
                  value: languageProvider.currentLanguage,
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'id',
                      child: Text('Indonesia'),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value != null) {
                      languageProvider.setLanguage(value);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
