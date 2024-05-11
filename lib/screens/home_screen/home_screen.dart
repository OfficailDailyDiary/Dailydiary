// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:daily_diary_app/constants/assets_constants.dart';
import 'package:daily_diary_app/constants/color_constants.dart';
import 'package:daily_diary_app/main.dart';
import 'package:daily_diary_app/routes/route_constants.dart';
import 'package:daily_diary_app/screens/home_screen/EditScreen.dart';
import 'package:daily_diary_app/screens/home_screen/Widget/AddNotesScreen.dart';
import 'package:daily_diary_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/Global.dart';
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
          Global.isUpdate = false;
          Get.to(
            EditAddNotesPage(),
          );
          // slideRightWidget(newPage: AddNoteScreen(), context: context);
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
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: InkWell(
                        onTap: () {
                          Global.isUpdate = true;
                          Get.to(
                            EditAddNotesPage(),
                            arguments: notes[i],
                          );
                          // Navigator.of(context)
                          //     .pus("edit_add_notes_page", arguments: data[i]);
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: ([...Colors.primaries]..shuffle())
                                .first
                                .shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 15, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${notes[i].title}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${notes[i].note}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        await Share.share(
                                            "Title : ${notes[i].title}\nDescription : ${notes[i].note}");
                                      },
                                      icon: const Icon(Icons.share_rounded),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text:
                                                "Title : ${notes[i].title}\nDescription : ${notes[i].note}",
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.black,
                                            content: Text(
                                              "Copied Note Successfully..",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.content_copy_rounded),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        NotesService.notesService.deleteNote(
                                            timeLaps:
                                                notes[i].timeLaps.toString());
                                        // CloudFirestoreHelper.cloudFirestoreHelper
                                        //     .deleteRecords(id: data[i].id);
                                      },
                                      icon: const Icon(Icons.delete_outline),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )

              // ? ListView.builder(
              //     itemCount: notes.length,
              //     itemBuilder: (context, index) {
              //       return Card(
              //         child: ListTile(
              //           title: Text(
              //             notes[index].title.toString(),
              //           ),
              //           subtitle: Text(
              //             notes[index].note.toString(),
              //           ),
              //         ),
              //       );
              //     },
              //   )
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
