import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/helper/database_helper.dart';
import 'package:flutter_notes/models/note.dart';
import 'package:flutter_notes/utils/constants.dart';

class NoteProvider with ChangeNotifier {
  Note note;
  List _items = [];

  List get items {
    return [..._items];
  }

  Future<Note> getNote(int id) async {
    print("entrei em getNote");
    final item  = note.firestore.doc(id as String);
    print("getNote");
    print(item);
    return _items.firstWhere((note) => note.id == id, orElse: () => null);
  }

  Future deleteNote(int id) async {
    print("deleteNote");
    note.deleteItem(id as String);
    return notifyListeners();
  }

  Future addOrUpdateNote(int id, String title, String content, String imagePath,
      EditMode editMode) async {
    note = Note(id: id, title: title, content: content, imagePath: imagePath);
    await note.save();
    notifyListeners();
    getNotes();
  }

  var _item = <Note>[];

  Future<void> getNotes() async {
    final snapshot = await FirebaseFirestore.instance.collection('notes').get();

    _item = List<Note>.from(
        snapshot.docs.map((notes) => Note.fromMap(notes.data()))).toList();

    _items = List<Note>.from(
        snapshot.docs.map((notes) => Note.fromMap(notes.data()))).toList();

    print('estou no getNotes');
    print(_item);
    notifyListeners();
  }
}
