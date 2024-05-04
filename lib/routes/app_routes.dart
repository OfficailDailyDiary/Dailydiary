import 'package:daily_diary_app/routes/route_constants.dart';
import 'package:daily_diary_app/screens/OnBoardingScreen/OnBoardingScreens.dart';
import 'package:daily_diary_app/screens/home_screen/Widget/AddNotesScreen.dart';
import 'package:daily_diary_app/screens/home_screen/home_screen.dart';
import 'package:daily_diary_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:daily_diary_app/service/notes_service.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

final List<GetPage> getPages = [
  GetPage(
    name: RouteConstants.signInPage,
    page: () => (NotesService.notesService.user != null)
        ? const HomePage()
        : const LoginScreen(),
  ),
  // GetPage(
  //   name: RouteConstants.homepage,
  //   page: () => const HomePage(),
  // ),
  GetPage(
    name: RouteConstants.onBoarding,
    page: () => const OnBoardingScreen1(),
  ),
  GetPage(
    name: RouteConstants.addNoteScreen,
    page: () => const AddNoteScreen(),
  )
];
