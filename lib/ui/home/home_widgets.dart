import 'dart:math';

import 'package:flutter/material.dart';
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
      height: MediaQuery.of(context).size.height / 3,
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
