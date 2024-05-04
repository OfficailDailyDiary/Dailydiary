import 'package:daily_diary_app/routes/app_routes.dart';
import 'package:daily_diary_app/routes/route_constants.dart';
import 'package:daily_diary_app/screens/OnBoardingScreen/OnBoardingScreens.dart';
import 'package:daily_diary_app/service/notes_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: getPages,
      );
    });
  }
}
