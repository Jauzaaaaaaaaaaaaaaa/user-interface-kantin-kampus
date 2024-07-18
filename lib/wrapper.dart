// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantin/kantin.dart';
import 'package:kantin/login_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Text(
              "An error occurred"
            ),
          );
        }
        if (snapshot.hasData) {
          return DaftarKantinKampus();
        } else {
          return LoginPage();
        }
      },),
    );
  }
}