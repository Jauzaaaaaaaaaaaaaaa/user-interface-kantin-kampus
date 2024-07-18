import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kantin/registrasi_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: // Pada bagian judul AppBar
        AppBar(
          title: const Text(
            'Login',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 22), // Ukuran teks diperbesar menjadi 22
          ),
          backgroundColor:const Color.fromARGB(255, 255, 165, 0),
          centerTitle: true,
        ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    Get.snackbar("Error", "Email or password is required");
                    return;
                  }
                  
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  }
                },
                child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                  foregroundColor: Colors.white, // Ubah warna teks menjadi putih
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistrasiPage()),
                  );
                },
                child: const Text(
                  'Belum punya akun? Registrasi',
                  style: TextStyle(fontFamily: 'Poppins', color: const Color.fromARGB(255, 255, 165, 0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
