import 'dart:async';
import 'package:bulk_basket/views/auth/register_screen.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  (FirebaseAuth.instance.currentUser != null)
                ? ProductScreen(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  )
                : RegisterScreen(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Color(0xff01bf61),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/wlinkit.png',
            height: 300,    
            width: 300,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(25.0),
          //   child: PrimaryButton(title: 'Get Started', ontTap: () {}),
          // )
        ],
      ),
    );
  }
}