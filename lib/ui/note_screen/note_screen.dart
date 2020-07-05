import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        centerTitle: true,
      ),
      body: ListView(),
    );
  }
}
