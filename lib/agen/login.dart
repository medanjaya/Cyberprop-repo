import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cyberprop/agen/menu.dart';

void checkAuthState(context) {
  FirebaseAuth.instance
  .authStateChanges()
  .listen(
    (User? user) {
      if (user != null) {
        Navigator.of(context)
        .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Menu(),
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
  user = TextEditingController(),
  pass = TextEditingController();
  
  @override
  void initState() {
    checkAuthState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(99, 226, 139, 33), // TODO : ini perlu kah? nb warna transparan
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/logo.png'),
            ),
            const Text(
              'Cyberprop (v0.pa) (UKS)',
              style: TextStyle(
                color: Color.fromARGB(255, 167, 86, 86),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Color.fromARGB(255, 167, 86, 86),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 239, 214),
                      border: InputBorder.none,
                    ),
                    controller: user,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 167, 86, 86),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 239, 214),
                      border: InputBorder.none,
                    ),
                    controller: pass,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: user.text,
                      password: pass.text,
                    );
                  }
                  on FirebaseAuthException catch (e) {
                    setState(
                      () {
                        ScaffoldMessenger.of(context)
                        .showSnackBar(
                          SnackBar(
                            content: Text(e.code)
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
                  foregroundColor: Color.fromARGB(255, 233, 239, 214),
                  backgroundColor: const Color.fromARGB(255, 167, 86, 86),
                  shape: RoundedRectangleBorder(
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
            ),
          ],
        ),
      ),
    );
  }
}
