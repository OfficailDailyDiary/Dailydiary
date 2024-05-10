import 'package:daily_diary_app/routes/app_routes.dart';
import 'package:daily_diary_app/routes/route_constants.dart';
import 'package:daily_diary_app/screens/OnBoardingScreen/OnBoardingScreens.dart';
import 'package:daily_diary_app/screens/SplashScreen.dart';
import 'package:daily_diary_app/screens/home_screen/home_screen.dart';
import 'package:daily_diary_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:daily_diary_app/service/notes_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // print('usi is now --->${NotesService.notesService.user!.id}');
  runApp(
    const MyApp(),
  );
}

String? currentUser;
SharedPreferences? prefs;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('user id is -------->>>${currentUser}');

    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // getPages: getPages/\,
        home: SplashScreen(),
      );
    });
  }
}
