import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_diary_app/modal/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/Global.dart';
import '../../service/notes_service.dart';

class EditAddNotesPage extends StatefulWidget {
  const EditAddNotesPage({Key? key}) : super(key: key);

  @override
  State<EditAddNotesPage> createState() => _EditAddNotesPageState();
}

class _EditAddNotesPageState extends State<EditAddNotesPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? title;
  String? description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearControllersAndVar();
  }

  @override
  Widget build(BuildContext context) {
    Notes? res;
    if (Global.isUpdate) {
      res = Get.arguments;

      titleController.text = "${res!.title}";
      descriptionController.text = "${res.note}";
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          (Global.isUpdate) ? "Edit Notes" : "Add Note",
          style: GoogleFonts.montserrat(
            color: Colors.black.withOpacity(0.9),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                Map<String, dynamic> data = {
                  "title": title,
                  "description": description,
                };

                if (Global.isUpdate) {
                  NotesService.notesService.addNotes(
                      title: titleController.text,
                      note: descriptionController.text,
                      timeLaps: res?.timeLaps ?? '');
                  Get.back();
                  // await CloudFirestoreHelper.cloudFirestoreHelper
                  //     .updateRecords(data: data, id: res!.id);
                } else {
                  NotesService.notesService.addNotes(
                      title: titleController.text,
                      note: descriptionController.text,
                      timeLaps:
                          DateTime.now().millisecondsSinceEpoch.toString());
                  Get.back();
                }
              }
            },
            child: Text(
              (Global.isUpdate) ? "SAVE" : "ADD",
              style: GoogleFonts.montserrat(
                color: Colors.black.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextFormField(
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: titleController,
                  decoration: textFieldDecoration("Title"),
                  onSaved: (val) {
                    title = val;
                  },
                  validator: (val) =>
                      (val!.isEmpty) ? "Enter Title First..." : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 25,
                  controller: descriptionController,
                  decoration: textFieldDecoration("Description"),
                  onSaved: (val) {
                    description = val;
                  },
                  validator: (val) =>
                      (val!.isEmpty) ? "Enter Description First..." : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      fillColor: ([...Colors.primaries]..shuffle()).first.shade100,
      filled: true,
    );
  }

  clearControllersAndVar() {
    titleController.clear();
    descriptionController.clear();

    title = null;
    description = null;
  }
}
