import 'package:flutter/cupertino.dart';
import 'package:notesapplication/Services/Api_service.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
 bool isLoading = true;
 List<Note> notes = [];

 NotesProvider (){
  fetchNotes();
 }

 void sortNotes(){
  notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
 }

 void addNote(Note note) {
  notes.add(note);
  //API SAVE
  sortNotes();
  notifyListeners();

  ApiService.addNote(note);
 }

 void updateNote(Note note) {
  int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
  notes[indexOfNote] = note;
  sortNotes();
  notifyListeners();
  ApiService.addNote(note);
 }

 void deleteNote(Note note) {
  int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
  notes.removeAt(indexOfNote);
  sortNotes();
  notifyListeners();
  ApiService.deleteNote(note);
 }

 void fetchNotes () async {
 notes = await ApiService.fetchNotes("ahmadsiddique7073@gmail.com");
 sortNotes();
 isLoading = false;
 notifyListeners();
 }

}