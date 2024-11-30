import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:cyberprop/agen/splash_screen.dart';
import 'package:cyberprop/provider/lightdark_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => LightDarkProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<LightDarkProvider>(context);
    return MaterialApp(
      title: 'Cyberprop | Property Marketplace',
      debugShowCheckedModeBanner: false,
      
      //TODO : bottomnav jadi putih waktu dark mode
      theme: ThemeData(
        colorScheme: colorProvider.enableDarkMode 
        ? ColorScheme.dark()
        : ColorScheme.fromSeed(
            seedColor: Colors.orange
          ),
        useMaterial3: false,
      ),  
      home: const SplashScreen(),
    );
  }
}