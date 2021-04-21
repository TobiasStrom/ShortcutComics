import 'package:flutter/material.dart';

class NavigatorBar extends StatelessWidget {
  final String text;
  final int fontSize;

  const NavigatorBar({Key key, this.text, this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()=> Navigator.pop(context),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 30
            ),
          ),
          IconButton(icon: Icon(Icons.home), onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false)),
        ]
    );
  }
}
