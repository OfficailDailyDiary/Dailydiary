import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_diary_app/modal/notes_modal.dart';
import 'package:daily_diary_app/routes/route_constants.dart';
import 'package:daily_diary_app/screens/home_screen/home_screen.dart';
import 'package:daily_diary_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class NotesService {
  NotesService._();
  static final NotesService notesService = NotesService._();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  GoogleSignInAccount? user;

  Future<dynamic> signInWithGoogle() async {
    try {
      user = await GoogleSignIn().signIn();
      prefs = await SharedPreferences.getInstance();
      final GoogleSignInAuthentication? googleAuth = await user?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      String userId = user?.id ?? '';
      prefs!.setString('user', userId);
      currentUser = prefs!.getString('user');

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(() => const HomePage());
    } on Exception catch (e) {
      // TODO
      if (kDebugMode) {
        print('auth exception->$e');
      }
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      print('hello');
      prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut().then((value) {
        currentUser = '';
        prefs!.remove('user');
        Get.offAll(const LoginScreen());
      });

      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  addNotes({required String title, required String note}) {
    return fireStore.collection('Notes').add({
      'title': title,
      'note': note,
      'userId': user!.id,
    });
  }

  Stream<List<Notes>> getNotes() {
    return fireStore
        .collection('Notes')
        .where('userId', isEqualTo: currentUser)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Notes.fromJson(e.data());
      }).toList();
    });
  }
}
