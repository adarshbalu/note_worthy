import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_worthy/data/database.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  const NoteScreen({Key key, this.note}) : super(key: key);
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController title, body;
  Note note;
  bool important = false, completed = false;
  Color yes = Colors.green, no = Colors.blue;
  final _formKey = GlobalKey<FormState>();
  String category, type;
  @override
  void initState() {
    note = widget.note;
    completed = note.completed;
    important = note.important;
    category = note.category ?? 'none';
    type = note.type ?? 'none';
    title = TextEditingController(text: widget.note.title ?? '');
    body = TextEditingController(text: widget.note.description ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Edit Note'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (completed)
                  completed = false;
                else
                  completed = true;
              });
            },
            icon: Icon(
              Icons.assignment_turned_in,
              size: 35,
              color: completed ? yes : no,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (important)
                  important = false;
                else
                  important = true;
              });
            },
            icon: Icon(
              Icons.favorite,
              size: 35,
              color: important ? yes : no,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 2,
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height / 1.5),
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 15.0, bottom: 0),
                          child: TextFormField(
                            onChanged: (v) {
                              _formKey.currentState.validate();
                            },
                            validator: (value) {
                              if (value.length > 50) {
                                return 'Title should be less than 50 characters';
                              }
                              return null;
                            },
                            controller: title,
                            style: textStyle.copyWith(fontSize: 21),
                            decoration: InputDecoration(
                              hintText: 'Title',
                              labelStyle: textStyle.copyWith(fontSize: 21),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 0, bottom: 0.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter note details';
                              }
                              if (value.length < 5) {
                                return 'Note must be more than 5 characters';
                              }
                              return null;
                            },
                            controller: body,
                            onChanged: (v) {
                              _formKey.currentState.validate();
                            },
                            style: textStyle.copyWith(fontSize: 18),
                            minLines: 11,
                            maxLines: 11,
                            decoration: InputDecoration(
                              hintText: 'Note',
                              labelStyle: textStyle.copyWith(fontSize: 18),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: DropdownButton(
                      hint: Text('Category'),
                      underline: SizedBox(),
                      onChanged: (v) {
                        setState(() {
                          category = v;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'none',
                          child: Text('None'),
                        ),
                        DropdownMenuItem(
                          value: 'Home',
                          child: Text('Home'),
                        ),
                        DropdownMenuItem(
                          value: 'Work',
                          child: Text('Work'),
                        ),
                      ],
                      value: category,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: DropdownButton(
                      hint: Text('Type'),
                      underline: SizedBox(),
                      onChanged: (v) {
                        setState(() {
                          type = v;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'none',
                          child: Text('None'),
                        ),
                        DropdownMenuItem(
                          value: 'TO-DO',
                          child: Text('To-do'),
                        ),
                      ],
                      value: type,
                    ),
                  )
                ],
              ),
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final Note newNote = note.copyWith(
                          important: important,
                          title: title.text,
                          description: body.text,
                          type: type,
                          category: category,
                          completed: completed);
                      List<Note> notes = await database.getAllNotes();
                      if (!notes.contains(note)) {
                        await database.insertNote(newNote);
                      } else {
                        await database.updateNote(newNote);
                      }
                      Navigator.pop(context);
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  color: Colors.green,
                  textColor: Colors.white,
                  icon: Icon(Icons.save),
                  label: Text(
                    'Save Note',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
