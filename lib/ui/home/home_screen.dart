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
  int importantNotes;
  Note _note = Note(
      category: 'none',
      type: 'none',
      title: '',
      description: '',
      completed: false,
      important: false,
      dueDate: DateTime.now(),
      dateCreated: DateTime.now());
  @override
  void initState() {
    parentController = ScrollController();
    super.initState();
    importantNotes = 0;
  }

  checkImportantNotes(List<Note> noteList) {
    for (var note in noteList) {
      if (note.important && !note.completed) importantNotes++;
    }
    return importantNotes;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: database.getAllNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !(snapshot.hasError)) {
              checkImportantNotes(snapshot.data);
              return Column(
                children: <Widget>[
                  importantNotes > 0
                      ? StreamBuilder(
                          stream: database.watchAllNotes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Note note = snapshot.data[index];
                                    if (note.important) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NoteScreen(
                                                note: note,
                                              ),
                                            )),
                                        child: ImportantCard(
                                          title: note.title,
                                          body: note.description,
                                        ),
                                      );
                                    } else
                                      return SizedBox();
                                  },
                                ),
                              );
                            } else if (snapshot.connectionState !=
                                ConnectionState.done)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            else
                              return SizedBox();
                          })
                      : SizedBox(),
                  SizedBox(
                    height: 8,
                  ),
                  StreamBuilder(
                      stream: database.watchAllNotes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            return Column(
                              children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                      'assets/add_note.png',
                                    ))),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                    )),
                                Text('No Notes added.'),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                )
                              ],
                            );
                          }
                          return Expanded(
                            child: CupertinoScrollbar(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Note note = snapshot.data[index];
                                    return Dismissible(
                                      key: Key(note.id.toString()),
                                      onDismissed: (direction) {
                                        database.deleteNote(note);
                                      },
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NoteScreen(
                                                note: note,
                                              ),
                                            )),
                                        child: NoteCard(
                                            title: note.title,
                                            date: note.dateCreated,
                                            type: note.type,
                                            category: note.category,
                                            body: note.description),
                                      ),
                                    );
                                  }),
                            ),
                          );
                        } else if (snapshot.connectionState !=
                            ConnectionState.done)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        else
                          return SizedBox();
                      }),
                ],
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
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
