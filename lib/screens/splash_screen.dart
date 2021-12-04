import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_jelantah_utama/screens/welcome_screen.dart';
import 'package:project_jelantah_utama/screens/login_screen.dart';

import 'login_screen2.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
          //LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'logo,',
          child: Image.asset('assets/tcare_logo.png'),
        ),
      ),
    );
  }
}
