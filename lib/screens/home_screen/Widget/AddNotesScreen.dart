// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:daily_diary_app/constants/assets_constants.dart';
import 'package:daily_diary_app/service/notes_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log("AddNoteScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              NotesService.notesService.addNotes(
                  title: titleController.text,
                  note: noteController.text,
                  timeLaps: DateTime.now().millisecondsSinceEpoch.toString());
              Get.back();
            },
            child: Text(
              "SAVE",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Gap(20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
                hintStyle: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Gap(10),
            Text(
              'Edited Saturday, 03 June 2023  11:25 am',
              style: TextStyle(
                color: Color(0xFF939393),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            Gap(20),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 31,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFDE55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                Gap(5),
                Text(
                  'Note Subtitle',
                  style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Gap(20),
            TextFormField(
              maxLines: 15,
              controller: noteController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Start Typing.....',
                hintStyle: TextStyle(
                  color: Color(0xFF939393),
                  fontSize: 15.13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Row(
          children: [
            ImageIcon(
              AssetImage(AssetConstants.add),
            ),
            Spacer(),
            ImageIcon(
              AssetImage(AssetConstants.moreVert),
            ),
          ],
        ),
      ),
    );
  }
}
