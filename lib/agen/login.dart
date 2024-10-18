import 'package:flutter/material.dart';
import 'menu.dart'; // Pastikan untuk mengimpor Menu

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 255, 223, 183),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('lib/assets/Logo.png')), // Pastikan ini sesuai
            const SizedBox(height: 20),

            // Username field
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Color.fromARGB(255, 167, 86, 86),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 239, 214),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Password field
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 167, 86, 86),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 239, 214),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Login button with full width as TextField
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke Menu setelah login berhasil
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Menu()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 167, 86, 86),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text('Login'),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Belum memiliki akun?',
              style: TextStyle(
                color: Color.fromARGB(100, 171, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
