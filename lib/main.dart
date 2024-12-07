import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';
import 'package:cyberprop/agen/splash_screen.dart';
import 'package:cyberprop/provider/lightdark_provider.dart';
import 'package:cyberprop/provider/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LightDarkProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<LightDarkProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      title: 'Cyberprop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: themeProvider.enableDarkMode
          ? const ColorScheme.dark() 
          : ColorScheme.fromSeed(seedColor: Colors.orange), 
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: themeProvider.enableDarkMode
            ? Colors.grey[900]
            : Colors.white, 
          selectedItemColor: themeProvider.enableDarkMode
            ? Colors.orangeAccent
            : Colors.orange,
          unselectedItemColor: Colors.grey,
        ),
      ),
      
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(languageProvider.currentLanguage), 
      supportedLocales: AppLocalizations.supportedLocales,
      
      home: const SplashScreen(),
    );
  }
}