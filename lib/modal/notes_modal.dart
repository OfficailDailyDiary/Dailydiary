// To parse this JSON data, do
//
//     final notes = notesFromJson(jsonString);

import 'dart:convert';

Notes notesFromJson(String str) => Notes.fromJson(json.decode(str));

String notesToJson(Notes data) => json.encode(data.toJson());

class Notes {
  String? title;
  String? note;
  String? userId;

  Notes({
    this.title,
    this.note,
    this.userId,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        title: json["title"],
        note: json["note"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "note": note,
        "userId": userId,
      };
}
