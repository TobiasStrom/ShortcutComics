import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double height;

  const Loading({this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
          child: Container(
            height: 300,
            child: Column(
              children: [
                CircularProgressIndicator(),
                Text('Check if you have internet connection')
              ],
            ),
          )),
    );
  }
}
