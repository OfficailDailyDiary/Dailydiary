// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:daily_diary_app/screens/home_screen/home_screen.dart';
import 'package:daily_diary_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/assets_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate() {
    if (currentUser == null) {
      Future.delayed(Duration(seconds: 3), () {
        Get.offAll(() => LoginScreen());
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Get.offAll(() => HomePage());
      });
    }
  }

  String? currentUser;
  SharedPreferences? prefs;
  getUser() async {
    prefs = await SharedPreferences.getInstance();
    currentUser = prefs!.getString('user');
    print('userv ois ---->>>$currentUser');
    navigate();
  }

  @override
  void initState() {
    super.initState();
    getUser();
    log("SplashScreen<><><>");
    // navigate();
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
