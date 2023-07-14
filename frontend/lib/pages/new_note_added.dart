import 'package:flutter/material.dart';
import 'package:notesapplication/pages/home_page.dart';
import 'package:notesapplication/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';


class AddNewPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewPage({super.key,required this.isUpdate,this.note});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  
  FocusNode notefocus = FocusNode();

  void addNewNote () {
    Note newNote = Note(
      id: const Uuid().v1(),
      userid: "ahmadsiddique7073@gmail.com",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider>(context,listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote () {
     widget.note!.title = titleController.text;
     widget.note!.content=contentController.text;
     widget.note!.dateadded = DateTime.now();
     Provider.of<NotesProvider>(context,listen: false).updateNote(widget.note!);
     Navigator.pop(context);
  }

  @override
  void initState() {
    
    super.initState();

    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (() {

            if(widget.isUpdate){
              //Update
             updateNote();
            }
            else{
              addNewNote();
            }
          }), icon:Icon(Icons.check),
          )
        ],
        title:  Text("Write Notes"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children:  [
            TextField(
              controller: titleController,
              autofocus: (widget.isUpdate==true)? false: true,
              onSubmitted: (value) {
                if(value!=""){
                  notefocus.requestFocus();
                }
              },
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
  
              ),
            ),

           Expanded(
            child:  TextField(
              controller: contentController,
              focusNode: notefocus,
              maxLines: null,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Notes",
              ),
            ),
           ),
          ],
        ),

        ),
      ),
    );
  }
}