import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_worthy/data/database.dart';
import 'package:note_worthy/ui/home/home_widgets.dart';
import 'package:note_worthy/ui/note_screen/note_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController parentController;
  int importantNotes = 0;
  Note _note = Note(
      category: 'None',
      type: 'None',
      title: '',
      description: '',
      completed: false,
      important: true,
      dateCreated: DateTime.now());
  @override
  void initState() {
    parentController = ScrollController();
    super.initState();
  }

  checkImportantNotes(List<Note> noteList) {
    for (var note in noteList) {
      if (note.important) importantNotes++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: database.watchAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    checkImportantNotes(snapshot.data);
                    print(importantNotes);
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Note note = snapshot.data[index];
                        if (note.important)
                          return ImportantCard(
                            title: note.title,
                            body: note.description,
                          );
                        else
                          return SizedBox();
                      },
                    );
                  } else
                    return SizedBox();
                }),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'All Notes',
              style: TextStyle(fontSize: 30),
            ),
          ),
          StreamBuilder(
              stream: database.watchAllNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Note note = snapshot.data[index];
                          return NoteCard(
                              title: note.title,
                              date: note.dateCreated.toString(),
                              type: note.type,
                              category: note.category,
                              body: note.description);
                        }),
                  );
                } else
                  return SizedBox();
              }),
        ],
      ),
      bottomNavigationBar: AddWidget(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteScreen(
                  note: _note,
                ),
              ))),
    );
  }
}
