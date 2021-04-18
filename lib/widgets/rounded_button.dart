
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  //Values to build rounded buttons;
  final String text;
  final double width;
  final double height;
  final GestureTapCallback onClick;
  final Color color;

  const RoundedButton({Key key, this.text, this.width, this.height, this.onClick, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(// To set button size
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onClick,
          child: Text(text),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(height/2),
            )
          ),
        ),
      ),
    );
  }
}
