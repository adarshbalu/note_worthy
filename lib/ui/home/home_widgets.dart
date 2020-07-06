import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_worthy/utils/constants.dart';

class ImportantCard extends StatelessWidget {
  final String title, body;
  const ImportantCard({Key key, @required this.title, @required this.body})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _random = new Random();
    final Color color = kColorList[_random.nextInt(kColorList.length)];
    String bodyText = body.length < 30 ? body : body.substring(0, 30);
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width / 2.4,
      height: MediaQuery.of(context).size.height / 3.1,
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: kImportantCardHeadingTextStyle,
          ),
          Divider(
            color: Colors.white,
          ),
          Text(
            bodyText,
            style: kImportantCardBodyTextStyle,
          )
        ],
      ),
    );
  }
}

class AddWidget extends StatelessWidget {
  final onTap;
  const AddWidget({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 3.4, 0,
            MediaQuery.of(context).size.width / 3.4, 5),
        child: RaisedButton.icon(
          color: Colors.green,
          textColor: Colors.white,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: onTap,
          icon: Icon(Icons.add),
          label: Text('Add Note'),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title, body, type, category;
  final DateTime date;
  const NoteCard({
    Key key,
    this.title,
    this.date,
    this.body,
    this.type,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0, top: 8),
                  child: Text(formatter.format(date)),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  body,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: Text(category == 'none' ? '' : category),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0, top: 8),
                  child: Text(type == 'none' ? '' : type),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyImportantNote extends StatelessWidget {
  const EmptyImportantNote({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.indigo.shade400,
              borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width / 2.3,
          height: MediaQuery.of(context).size.height / 3.4,
          alignment: Alignment.center,
          child: Text(
            'No important notes',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
