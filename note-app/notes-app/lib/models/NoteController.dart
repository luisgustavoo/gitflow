import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_notes/models/note.dart';

class NoteController extends ChangeNotifier {

  var _item = <Note>[];

  Future<void> getNotes() async {
    final snapshot = await FirebaseFirestore.instance.collection('notes').get();

    _item = List<Note>.from(
        snapshot.docs.map((notes) => Note.fromMap(notes.data()))).toList();

    print(_item);
    notifyListeners();
  }


}