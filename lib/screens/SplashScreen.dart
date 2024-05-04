// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:daily_diary_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

import '../constants/assets_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    log("SplashScreen<><><>");
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AssetConstants.splash),
            ),
          ),
          child: Image.asset(AssetConstants.logo),
        ),
      ),
    );
  }
}
