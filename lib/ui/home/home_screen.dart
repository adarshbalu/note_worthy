import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_worthy/ui/home/home_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
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
          )
        ],
      ),
    );
  }
}
