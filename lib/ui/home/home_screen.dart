import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_worthy/ui/home/home_widgets.dart';
import 'package:note_worthy/ui/note_screen/note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController parentController;
  @override
  void initState() {
    parentController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
          centerTitle: true,
        ),
        body: ListView(
          controller: parentController,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  ImportantCard(
                    title: 'Title',
                    body: 'BOduasdlaks',
                  ),
                  ImportantCard(
                    title: 'Title',
                    body: 'BOduasdlaks',
                  ),
                  ImportantCard(
                    title: 'Title',
                    body: 'BOduasdlaks',
                  ),
                  ImportantCard(
                    title: 'Title',
                    body: 'BOduasdlaks',
                  ),
                  ImportantCard(
                    title: 'Title',
                    body: 'BOduasdlaks',
                  ),
                  ImportantCard(
                    title: 'Title',
                    body: 'BOduasdlaks',
                  ),
                ],
              ),
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
            NoteCard(
              title: 'Name of the Note',
              date: '12-01-2020',
              type: 'To-do',
              category: 'Home',
              body:
                  'A container that is typically used with Scaffold.bottomNavigationBar, and can have a notch along the top that makes room for an overlapping FloatingActionButton.Typically used with a Scaffold and a FloatingActionButton.link',
            ),
            NoteCard(
              category: 'Work',
              title: 'Name of the Note',
              date: '12-01-2020',
              type: 'List',
              body:
                  'A container that is typically used with Scaffold.bottomNavigationBar, and can have a notch along the top that makes room for an overlapping FloatingActionButton.Typically used with a Scaffold and a FloatingActionButton.link',
            ),
          ],
        ),
        bottomNavigationBar: AddWidget(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteScreen())),
        ));
  }
}
