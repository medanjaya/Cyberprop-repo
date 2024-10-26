import 'package:cyberphobe_project/provider/lightdark_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'agen/menu.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => LightdarkProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LightdarkProvider>(context);
    return MaterialApp(
      title: 'Cyberprop | Property Marketplace',
      debugShowCheckedModeBanner: false,
      theme: prov.enableDarkMode 
          ? ThemeData.dark() 
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orange,
              ),
              useMaterial3: false,
            ),
      home: const Menu(),
    );
  }
}
