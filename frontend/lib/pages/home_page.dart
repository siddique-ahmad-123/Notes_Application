import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapplication/pages/new_note_added.dart';
import 'package:notesapplication/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 
  @override
  Widget build(BuildContext context) {

    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Notes App"),
        centerTitle: true,
      ),
       body: (notesProvider.isLoading == false) ? SafeArea(
        child: Container(
          child: (notesProvider.notes.length>0) ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: notesProvider.notes.length,
             itemBuilder: (context, index) {
             
             Note currentNote = notesProvider.notes[index];

               return GestureDetector(
                onTap: () {
                  //Update
                  Navigator.push(context,
                  CupertinoPageRoute(
                    builder: (context){
                      return AddNewPage(isUpdate: true, note: currentNote,);
                    }
                    )
                  );
                },
                onLongPress: () {
                  //delete
                  notesProvider.deleteNote(currentNote);
                },
                 child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    )
                   ),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentNote.title!, style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      const SizedBox(height: 8,),
                      Text(currentNote.content!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 118, 108, 108)
                      ),
                      maxLines: 6, overflow: TextOverflow.ellipsis,
                      ),
                    ],
                   ),
                   
                 ),
               );
               
             },
             ) : Center(
              child: Text("No Notes"),
             )
             
             ),
        ) : Center(
          child: CircularProgressIndicator(),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context){
                  return  AddNewPage(isUpdate: false,);
                }
                )
              );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
           ),
        );
  
  
  }
}