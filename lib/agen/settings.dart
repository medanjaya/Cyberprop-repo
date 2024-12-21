import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async'; // Untuk Timer

import 'package:cyberprop/provider/lightdark_provider.dart';
import 'package:cyberprop/provider/language_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class MyNotification {
  late BuildContext context;
  MyNotification(BuildContext context) {
    this.context = context;
  }

  // Timer untuk logika manual
  Timer? _timer;
  int _counter = 0;

  void startCustomNotification() {
    // Timer untuk logika manual
    _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      _counter++;
      debugPrint('Notifikasi ke-$_counter setelah ${_counter * 10} detik.');

      // Membuat notifikasi instan
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: _counter, // ID unik untuk setiap notifikasi
          channelKey: 'manual_channel',
          title: '${AppLocalizations.of(context)!.reminder} #$_counter!', 
          body: '${AppLocalizations.of(context)!.thisisyour} $_counter ${AppLocalizations.of(context)!.notifafter} ${_counter * 10} ${AppLocalizations.of(context)!.seconds}', 
          notificationLayout: NotificationLayout.Default,
        ),
      );
    });
  }

  Future<void> createScheduleNotification() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications()
            .requestPermissionToSendNotifications()
            .then((_) => Navigator.pop(context));
      }
    });

    // Membuat notifikasi yang dijadwalkan
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'schedule_channel',
        title: 'Scheduled Notification',
        body: 'This notification was scheduled to repeat every 10 seconds.',
      ),
      schedule: NotificationInterval(
        interval: Duration(seconds: 10), // Interval dalam detik
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true, // Memastikan presisi notifikasi
      ),
    );
    debugPrint("Notifikasi dijadwalkan setiap 10 detik.");
  }
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LightDarkProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    MyNotification notify = MyNotification(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(color: Colors.white),
        ),
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
                    setState(() {
                      themeProvider.setBrightness = e;
                    });
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
            const SizedBox(height: 18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notifikasi'),
                ElevatedButton(
                  onPressed: () {
                    // Memulai notifikasi setiap 10 detik
                    notify.startCustomNotification();
                  },
                  child: Text(AppLocalizations.of(context)!.notifyme),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

