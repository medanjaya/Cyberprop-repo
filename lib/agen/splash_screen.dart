import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cyberprop/agen/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToNextScreen() { //TODO : ini nanti cari cara ngeload appnya, biar jadi loading beneran
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainMenu(),
          ),
        );
      },
    );
  }
  
  @override
  void initState() {
    super.initState();
    moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 210, 169),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo-new.png',
              height: 196.0,
            ),
            const SizedBox(height: 2.0),
            const Text(
              'cyberprop',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
