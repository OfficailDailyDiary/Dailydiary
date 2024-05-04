// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:daily_diary_app/constants/assets_constants.dart';
import 'package:daily_diary_app/constants/color_constants.dart';
import 'package:daily_diary_app/routes/route_constants.dart';
import 'package:daily_diary_app/screens/home_screen/Widget/AddNotesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_transitions/route_transitions.dart';

import '../../modal/notes_modal.dart';
import '../../service/notes_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // backgroundColor: ColorConstants.primaryColor,
        // leading: Container(
        //   alignment: Alignment.center,
        //   padding: EdgeInsets.all(8.px),
        //   child: SvgPicture.asset(
        //     AssetConstants.appIcon,
        //   ),
        // ),
        title: const Text(
          "My Notes",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          ImageIcon(
            AssetImage(AssetConstants.searchIcon),
          ),
          Gap(20),
          IconButton(
            onPressed: () => NotesService.notesService.signOutFromGoogle(),
            icon: const Icon(Icons.logout_outlined),
          ),
          // ImageIcon(
          //   AssetImage(AssetConstants.drawer),
          // ),
          Gap(20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          slideRightWidget(newPage: AddNoteScreen(), context: context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddNoteScreen()),
          // );
        },
        child: Icon(Icons.edit),
        backgroundColor: ColorConstants.yellowColor,
      ),
      // body: Container(
      //   alignment: Alignment.center,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Image.asset(AssetConstants.noNotes),
      //     ],
      //   ),
      // ),
      body: StreamBuilder(
        stream: NotesService.notesService.getNotes(),
        builder: (context, snapshot) {
          List<Notes> notes = snapshot.data ?? [];
          return (notes.isNotEmpty)
              ? ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          notes[index].title.toString(),
                        ),
                        subtitle: Text(
                          notes[index].note.toString(),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetConstants.noNotes),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
