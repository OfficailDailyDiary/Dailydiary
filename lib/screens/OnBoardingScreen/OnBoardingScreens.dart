// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:daily_diary_app/screens/SplashScreen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

final PageController _pageController = PageController(initialPage: 0);
int _currentPage = 0;

final List<Widget> _pages = [
  OnboardingPage(
    image: 'assets/images/on1.png',
    title: 'Welcome to MyApp',
    description: 'This is an awesome app!',
  ),
  OnboardingPage(
    image: 'assets/images/on2.png',
    title: 'Explore Features',
    description: 'Discover all the amazing features.',
  ),
  OnboardingPage(
    image: 'assets/images/on3.png',
    title: 'Get Started',
    description: 'Start using MyApp now!',
  ),
];

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _pages[index];
              },
            ),
            Positioned(
              bottom: 30.0,
              left: 20.0,
              right: 20.0,
              child: Row(
                children: [
                  DotsIndicator(
                    dotsCount: _pages.length,
                    position: _currentPage,
                    decorator: DotsDecorator(
                      // color: Colors.blackg,
                      activeColor: Colors.black,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _nextPage();
                      // Navigate to the next screen or perform any action
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Start' : "Next",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      log("erfaes");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
          (route) => false);
      // You can navigate to the next screen here or perform any other action
    }
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(_indicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 200.0,
          ),
          SizedBox(height: 30.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
