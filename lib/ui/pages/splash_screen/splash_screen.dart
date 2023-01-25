// ignore_for_file: avoid_unnecessary_containers, unused_import

import 'dart:async';

import 'package:book_apps/ui/pages/book_list_page.dart';
import 'package:book_apps/ui/pages/onboarding_screen/onbording_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OnbordingPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color(0xff6746CC),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Image(
                    width: 250,
                    image: AssetImage('assets/images/menubook.png'),
                  ),
                ),
              ),
              Text(
                "W  E  L  C  O  M  E        T  O",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'BOOKLY',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
