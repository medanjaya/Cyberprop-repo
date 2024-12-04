import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cyberprop/agen/main_menu.dart';

void checkAuthState(context) { //TODO : cek ini butuh atau nga sebenarnya
  FirebaseAuth.instance
  .authStateChanges()
  .listen(
    (User? user) {
      if (user != null) {
        Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainMenu(),
          ),
          (Route route) => false
        );
      }
    },
  );
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController
  userController = TextEditingController(),
  passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 96.0,
          right: 96.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              width: 128.0,
              height: 128.0,
              child: Image(
                image: AssetImage('assets/logo-new.png'),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Username',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 168, 86, 86),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 4.0),
            TextField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 233, 239, 214),
                border: InputBorder.none,
              ),
              controller: userController,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Password',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 168, 86, 86),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 4.0),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 233, 239, 214),
                border: InputBorder.none,
              ),
              controller: passController,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: userController.text,
                    password: passController.text,
                  );
                }
                on FirebaseAuthException catch (e) {
                  setState( //TODO : ngapain di setstate ya..
                    () {
                      ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Text(e.message.toString())
                        ),
                      );
                    }
                  );
                }
                if (context.mounted) {
                  checkAuthState(context);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 233, 239, 214),
                backgroundColor: const Color.fromARGB(255, 168, 86, 86),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 210, 170),
    );
  }
}
